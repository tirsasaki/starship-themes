# Starship Themes

A collection of custom themes for [Starship](https://starship.rs). Each theme is distributed as a standalone TOML file, so you can install one without copying the rest of the repository.

The collection currently focuses on Zsh and Nerd Font icons. Every theme enables Starship's OS module and automatically displays a matching icon for the detected operating system or Linux distribution. More themes, color palettes, layouts, and shell styles can be added over time.

## Table of contents

- [Theme catalog](#theme-catalog)
  - [Theme design rules](#theme-design-rules)
  - [Amethyst Night](#amethyst-night)
  - [Wabi Sabi](#wabi-sabi)
  - [Frostline](#frostline)
  - [Ember Retro](#ember-retro)
  - [Sakura Dawn](#sakura-dawn)
  - [Void Circuit](#void-circuit)
  - [Oceanic Pulse](#oceanic-pulse)
  - [Monochrome Orbit](#monochrome-orbit)
- [Requirements](#requirements)
- [Installation](#installation)
- [Switch or update a theme](#switch-or-update-a-theme)
- [Verify a theme](#verify-a-theme)
- [Customize a theme](#customize-a-theme)
- [Restore the previous configuration](#restore-the-previous-configuration)
- [Repository structure](#repository-structure)
- [Adding a theme](#adding-a-theme)
- [Preview image guidelines](#preview-image-guidelines)
- [Troubleshooting](#troubleshooting)
  - [Icons appear as boxes](#icons-appear-as-boxes)
  - [Starship does not appear](#starship-does-not-appear)
  - [A theme reports a configuration error](#a-theme-reports-a-configuration-error)
- [License](#license)

## Theme catalog

The **Style** column shows the prompt model used by each theme.

| Theme | Style | Colors | Configuration | Preview |
| --- | --- | --- | --- | --- |
| [Amethyst Night](#amethyst-night) | Two-line Powerline | Purple, pink, cyan | [`amethyst-night.toml`](themes/amethyst-night.toml) | ![Amethyst Night](assets/previews/amethyst-night.png) |
| [Wabi Sabi](#wabi-sabi) | Two-line segmented | Indigo, matcha, terracotta | [`wabi-sabi.toml`](themes/wabi-sabi.toml) | ![Wabi Sabi](assets/previews/wabi-sabi.png) |
| [Frostline](#frostline) | Compact one-line | Ice blue, navy, white | [`frostline.toml`](themes/frostline.toml) | ![Frostline](assets/previews/frostline.png) |
| [Ember Retro](#ember-retro) | Two-line block | Amber, rust, cream | [`ember-retro.toml`](themes/ember-retro.toml) | ![Ember Retro](assets/previews/ember-retro.png) |
| [Sakura Dawn](#sakura-dawn) | Compact one-line | Soft pink, lavender, gray | [`sakura-dawn.toml`](themes/sakura-dawn.toml) | ![Sakura Dawn](assets/previews/sakura-dawn.png) |
| [Void Circuit](#void-circuit) | Minimal one-line | Lime, cyan, near-black | [`void-circuit.toml`](themes/void-circuit.toml) | ![Void Circuit](assets/previews/void-circuit.png) |
| [Oceanic Pulse](#oceanic-pulse) | Developer dashboard | Teal, blue, coral | [`oceanic-pulse.toml`](themes/oceanic-pulse.toml) | ![Oceanic Pulse](assets/previews/oceanic-pulse.png) |
| [Monochrome Orbit](#monochrome-orbit) | Minimal two-line | White, gray, lavender | [`monochrome-orbit.toml`](themes/monochrome-orbit.toml) | ![Monochrome Orbit](assets/previews/monochrome-orbit.png) |

Preview images are stored in [`assets/previews/`](assets/previews/).

### Theme design rules

Every completed theme should:

- have a unique palette and a clearly defined prompt model
- remain readable when a command fails or a Git repository is dirty
- include a matching file in `themes/` and preview in `assets/previews/`
- document any extra font or shell requirement
- avoid showing expensive modules unless their context is detected
- pass `starship print-config` and render successfully before being marked **Available**

## Amethyst Night

Amethyst Night is a two-line Powerline-style prompt with a purple palette inspired by Dracula. It displays the operating system, user, hostname, directory, Git status, command duration, exit status, time, shell, and detected development tools.

Included modules:

- automatically detected OS and Linux distribution icons
- Git branch and working-tree status
- command duration and exit status
- Python, Node.js, Rust, Go, Docker, Kubernetes, Terraform, and AWS
- success, error, and Vim-mode indicators

## Wabi Sabi

A restrained two-line prompt inspired by Japanese wabi-sabi aesthetics. Its indigo, bamboo, matcha, and terracotta palette keeps the directory and Git context distinct, while status, command duration, and time remain quietly aligned on the right.

## Frostline

A compact one-line prompt with an ice-blue palette. It keeps the directory, Git state, detected language runtime, and command duration visible without taking another terminal row.

## Ember Retro

A warm two-line prompt inspired by amber CRT terminals. User and host information sit in a rust-colored block, while the working directory uses a brighter amber segment.

## Sakura Dawn

A soft pink and lavender one-line theme intended for bright or pastel terminal backgrounds. Git status uses small blossom markers to keep the layout light.

## Void Circuit

The smallest theme in the collection. It shows only the current directory, Git context, prompt character, and right-aligned failure or duration information.

## Oceanic Pulse

A developer dashboard with project and Git context on the left, plus language runtimes, Docker, Kubernetes, command duration, and time on the right when detected.

## Monochrome Orbit

A restrained two-line prompt using grayscale and one lavender accent. It remains readable in low-color setups while retaining clear success and error states.

## Requirements

The installer is intended for Linux, macOS, or another Unix-like environment with `/bin/sh`. Before installing a theme, make sure the following requirements are available:

1. **[Starship](https://starship.rs/guide/#step-1-install-starship)** — required to render the prompt and validate the downloaded configuration. The installer can save a theme before Starship is installed, but the prompt will not appear until Starship is available.
2. **A supported shell** — Zsh, Bash, and Fish are detected automatically, and the installer adds the appropriate Starship initialization line. Other shells require [manual Starship setup](https://starship.rs/guide/#step-2-set-up-your-shell-to-use-starship).
3. **A download tool** — the commands in this README use `curl`. The installer itself can use either `curl` or `wget`.
4. **A [Nerd Font](https://www.nerdfonts.com/)** — required for the icons used by the themes. JetBrainsMono Nerd Font and MesloLGS Nerd Font are known options.

Check the command-line requirements with:

```bash
starship --version
basename "$SHELL"
command -v curl || command -v wget
```

After installing a Nerd Font, select it in your terminal emulator and restart the terminal. Installing the font without selecting it will leave some icons as empty boxes. Use Nerd Fonts 3.4.0 or newer for the dedicated CachyOS glyph; older versions may display it as a box.

## Installation

Open the interactive theme selector with one command:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/tirsasaki/starship-themes/main/install.sh)"
```

Use `↑`/`↓` or `j`/`k` to move, press `Enter` to install the highlighted theme, or press `q` to quit. **Amethyst Night** is highlighted by default.

The interactive selector reads directly from the terminal, so it still works when the installer is downloaded through command substitution. If no interactive terminal is available, it safely installs Amethyst Night.

To skip the menu and install a specific theme directly:

```bash
curl -fsSL https://raw.githubusercontent.com/tirsasaki/starship-themes/main/install.sh | sh -s -- frostline
```

The installer:

- shows a dependency-free terminal selector
- downloads and validates the selected theme
- backs up an existing `starship.toml` with a timestamp
- installs it to `${XDG_CONFIG_HOME:-~/.config}/starship.toml`
- enables Starship automatically for Zsh, Bash, or Fish
- leaves existing shell integration unchanged when it is already configured

Starship must be installed before the prompt can appear. If you install a theme first, install Starship afterward, then open a new terminal to load the prompt.

List available theme names from the installer at any time:

```bash
curl -fsSL https://raw.githubusercontent.com/tirsasaki/starship-themes/main/install.sh | sh -s -- --list
```

## Switch or update a theme

Run the installer again to select another theme or reinstall the same theme by name. The current configuration is backed up automatically before it is replaced:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/tirsasaki/starship-themes/main/install.sh)"
```

To switch or update directly by theme name:

```bash
curl -fsSL https://raw.githubusercontent.com/tirsasaki/starship-themes/main/install.sh | sh -s -- wabi-sabi
```

## Verify a theme

Check the active configuration:

```bash
starship print-config >/dev/null && echo "Starship theme loaded"
```

Test a repository theme before installing it:

```bash
STARSHIP_CONFIG="$PWD/themes/amethyst-night.toml" starship prompt
```

## Customize a theme

Edit the installed configuration:

```text
~/.config/starship.toml
```

For Amethyst Night, the colors are defined under `[palettes.amethyst_night]`. Changing this local file does not modify the repository copy.

To keep a customized version, give it a separate filename before pulling repository updates:

```bash
cp ~/.config/starship.toml ~/my-starship-theme.toml
```

## Restore the previous configuration

The installer creates timestamped backups next to `starship.toml`. List them, then restore the one you want:

```bash
ls -1 ~/.config/starship.toml.backup-*
cp ~/.config/starship.toml.backup-YYYYMMDD-HHMMSS ~/.config/starship.toml
```

Open a new terminal after restoring it.

To remove the active theme without restoring another configuration:

```bash
rm ~/.config/starship.toml
exec zsh
```

## Repository structure

```text
starship-themes/
├── assets/
│   └── previews/           # Theme screenshots
├── themes/
│   ├── amethyst-night.toml
│   ├── ember-retro.toml
│   ├── frostline.toml
│   ├── monochrome-orbit.toml
│   ├── oceanic-pulse.toml
│   ├── sakura-dawn.toml
│   ├── void-circuit.toml
│   └── wabi-sabi.toml
├── install.sh             # One-command installer
├── LICENSE
└── README.md
```

New themes should use a lowercase kebab-case filename, for example `violet-dawn.toml`. Its preview image should use the same base name, such as `assets/previews/violet-dawn.png`.

## Adding a theme

To add another theme:

1. Place the tested Starship configuration in `themes/<theme-name>.toml`.
2. Place its screenshot in `assets/previews/<theme-name>.png`.
3. Add it to the theme catalog.
4. Add a short section describing its layout, palette, and notable modules.
5. Test it with:

```bash
STARSHIP_CONFIG="$PWD/themes/<theme-name>.toml" starship print-config >/dev/null
STARSHIP_CONFIG="$PWD/themes/<theme-name>.toml" starship prompt
```

Submit additions through a pull request so the configuration and preview can be reviewed together.

## Preview image guidelines

Use PNG or WebP. Crop the image to the terminal area, keep text readable, and avoid including private paths, usernames, hostnames, tokens, or command history.

Recommended naming:

```text
assets/previews/<theme-name>.png
```

After uploading an image, replace `Image coming soon` in the catalog with:

```markdown
![Theme Name](assets/previews/theme-name.png)
```

## Troubleshooting

### Icons appear as boxes

Select a Nerd Font in the terminal settings, then restart the terminal. JetBrainsMono Nerd Font and MesloLGS Nerd Font are known options.

### Starship does not appear

Confirm that Zsh loads Starship:

```bash
grep -n "starship init zsh" ~/.zshrc
```

If the command returns nothing, add the initialization line from the Zsh section above.

### A theme reports a configuration error

Run Starship with the affected file:

```bash
STARSHIP_CONFIG="$PWD/themes/amethyst-night.toml" starship print-config
```

Starship will print the parsing error and its location. Replace the local configuration with an unmodified theme file if needed.

## License

The themes in this repository are available under the [MIT License](LICENSE).
