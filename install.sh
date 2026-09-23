#!/bin/sh

set -eu

REPOSITORY="tirsasaki/starship-themes"
DEFAULT_THEME="neon-shogun"
BASE_URL="${STARSHIP_THEMES_BASE_URL:-https://raw.githubusercontent.com/${REPOSITORY}/main}"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
CONFIG_FILE="$CONFIG_DIR/starship.toml"

THEMES="
amethyst-night
ember-retro
frostline
monochrome-orbit
neon-shogun
oceanic-pulse
sakura-dawn
void-circuit
"

usage() {
    cat <<EOF
Usage: install.sh [THEME]
       install.sh --list

Installs a Starship theme and enables Starship for the current shell.
When THEME is omitted, ${DEFAULT_THEME} is installed.
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
        theme=$DEFAULT_THEME
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
