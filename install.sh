#!/bin/sh

set -eu

REPOSITORY="tirsasaki/starship-themes"
DEFAULT_THEME="amethyst-night"
BASE_URL="${STARSHIP_THEMES_BASE_URL:-https://raw.githubusercontent.com/${REPOSITORY}/main}"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
CONFIG_FILE="$CONFIG_DIR/starship.toml"

THEMES="amethyst-night
ember-retro
frostline
monochrome-orbit
neon-shogun
oceanic-pulse
sakura-dawn
void-circuit"

usage() {
    cat <<EOF
Usage: install.sh [THEME]
       install.sh --list

Opens an interactive theme selector when THEME is omitted.
Use Up/Down or j/k to move, Enter to install, and q to quit.
In a non-interactive terminal, ${DEFAULT_THEME} is installed.
EOF
}

list_themes() {
    printf '%s\n' "$THEMES" | while IFS= read -r theme; do
        if [ -n "$theme" ]; then
            printf '  %s\n' "$theme"
        fi
    done
    return 0
}

is_valid_theme() {
    printf '%s\n' "$THEMES" | grep -Fxq "$1"
}

theme_at() {
    printf '%s\n' "$THEMES" | sed -n "${1}p"
}

select_theme() {
    theme_count=$(printf '%s\n' "$THEMES" | wc -l | tr -d ' ')
    selected=1
    default_index=1
    index=1

    while IFS= read -r candidate; do
        if [ "$candidate" = "$DEFAULT_THEME" ]; then
            default_index=$index
            break
        fi
        index=$((index + 1))
    done <<EOF
$THEMES
EOF
    selected=$default_index

    old_stty=$(stty -g < /dev/tty)
    trap 'stty "$old_stty" < /dev/tty; printf "\033[?25h" > /dev/tty' EXIT HUP INT TERM
    stty -echo -icanon min 1 time 0 < /dev/tty
    printf '\033[?25l' > /dev/tty

    while :; do
        printf '\033[2J\033[H' > /dev/tty
        printf '\033[1;35mStarship Theme Installer\033[0m\n' > /dev/tty
        printf 'Choose a theme to install\n\n' > /dev/tty

        index=1
        while IFS= read -r candidate; do
            if [ "$index" -eq "$selected" ]; then
                if [ "$candidate" = "$DEFAULT_THEME" ]; then
                    printf '  \033[1;36m❯ %s\033[0m \033[2m(default)\033[0m\n' "$candidate" > /dev/tty
                else
                    printf '  \033[1;36m❯ %s\033[0m\n' "$candidate" > /dev/tty
                fi
            elif [ "$candidate" = "$DEFAULT_THEME" ]; then
                printf '    %s \033[2m(default)\033[0m\n' "$candidate" > /dev/tty
            else
                printf '    %s\n' "$candidate" > /dev/tty
            fi
            index=$((index + 1))
        done <<EOF
$THEMES
EOF

        printf '\n\033[2m↑/↓ or j/k: move   Enter: install   q: quit\033[0m\n' > /dev/tty
        key=$(dd bs=1 count=1 2>/dev/null < /dev/tty)

        case "$key" in
            '')
                theme=$(theme_at "$selected")
                break
                ;;
            j)
                selected=$((selected % theme_count + 1))
                ;;
            k)
                selected=$(((selected + theme_count - 2) % theme_count + 1))
                ;;
            q|Q)
                stty "$old_stty" < /dev/tty
                printf '\033[?25h\033[2J\033[HInstallation cancelled.\n' > /dev/tty
                trap - EXIT HUP INT TERM
                exit 0
                ;;
            "$(printf '\033')")
                key2=$(dd bs=1 count=1 2>/dev/null < /dev/tty)
                if [ "$key2" = "[" ]; then
                    key3=$(dd bs=1 count=1 2>/dev/null < /dev/tty)
                    case "$key3" in
                        A) selected=$(((selected + theme_count - 2) % theme_count + 1)) ;;
                        B) selected=$((selected % theme_count + 1)) ;;
                    esac
                fi
                ;;
        esac
    done

    stty "$old_stty" < /dev/tty
    printf '\033[?25h\033[2J\033[H' > /dev/tty
    trap - EXIT HUP INT TERM
}

download() {
    url=$1
    output=$2

    if command -v curl >/dev/null 2>&1; then
        curl -fsSL "$url" -o "$output"
    elif command -v wget >/dev/null 2>&1; then
        wget -qO "$output" "$url"
    else
        printf 'Error: curl or wget is required.\n' >&2
        exit 1
    fi
}

enable_shell_integration() {
    shell_name=$(basename "${SHELL:-}")

    case "$shell_name" in
        zsh)
            shell_config="$HOME/.zshrc"
            init_line='eval "$(starship init zsh)"'
            ;;
        bash)
            shell_config="$HOME/.bashrc"
            init_line='eval "$(starship init bash)"'
            ;;
        fish)
            shell_config="${XDG_CONFIG_HOME:-$HOME/.config}/fish/config.fish"
            init_line='starship init fish | source'
            ;;
        *)
            printf 'Shell integration skipped: unsupported shell "%s".\n' "${shell_name:-unknown}"
            return
            ;;
    esac

    mkdir -p "$(dirname "$shell_config")"
    touch "$shell_config"

    if grep -Fq 'starship init' "$shell_config"; then
        printf 'Starship is already enabled in %s.\n' "$shell_config"
    else
        {
            printf '\n# Starship prompt\n'
            printf '%s\n' "$init_line"
        } >> "$shell_config"
        printf 'Enabled Starship in %s.\n' "$shell_config"
    fi
}

case "${1:-}" in
    -h|--help)
        usage
        exit 0
        ;;
    -l|--list)
        printf 'Available themes:\n'
        list_themes
        exit 0
        ;;
    '')
        if [ -t 1 ] && [ -r /dev/tty ] && [ -w /dev/tty ]; then
            select_theme
        else
            theme=$DEFAULT_THEME
            printf 'No interactive terminal detected; installing default theme %s.\n' "$theme"
        fi
        ;;
    *)
        theme=$1
        ;;
esac

if ! is_valid_theme "$theme"; then
    printf 'Error: unknown theme "%s".\n\nAvailable themes:\n' "$theme" >&2
    list_themes >&2
    exit 1
fi

mkdir -p "$CONFIG_DIR"
temporary_file=$(mktemp "$CONFIG_DIR/.starship.toml.XXXXXX")
trap 'rm -f "$temporary_file"' EXIT HUP INT TERM

download "$BASE_URL/themes/$theme.toml" "$temporary_file"

if command -v starship >/dev/null 2>&1; then
    if ! STARSHIP_CONFIG="$temporary_file" starship print-config >/dev/null; then
        printf 'Error: downloaded theme failed Starship validation.\n' >&2
        exit 1
    fi
else
    printf 'Warning: Starship is not installed; the theme will be ready after Starship is installed.\n' >&2
fi

if [ -f "$CONFIG_FILE" ]; then
    timestamp=$(date '+%Y%m%d-%H%M%S')
    backup_file="$CONFIG_FILE.backup-$timestamp"
    cp "$CONFIG_FILE" "$backup_file"
    printf 'Backed up existing configuration to %s.\n' "$backup_file"
fi

chmod 600 "$temporary_file"
mv "$temporary_file" "$CONFIG_FILE"
trap - EXIT HUP INT TERM

enable_shell_integration

printf '\nInstalled %s to %s.\n' "$theme" "$CONFIG_FILE"
printf 'Open a new terminal or restart your shell to use it.\n'
