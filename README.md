# Starship Themes

A collection of custom themes for [Starship](https://starship.rs). Each theme is distributed as a standalone TOML file, so you can install one without copying the rest of the repository.

The collection currently focuses on Zsh and Nerd Font icons. More themes, color palettes, layouts, and shell styles can be added over time.

## Theme catalog

| Theme | Style | Colors | Configuration | Preview |
| --- | --- | --- | --- | --- |
| [Amethyst Night](#amethyst-night) | Two-line Powerline | Purple, Dracula-inspired | [`themes/amethyst-night.toml`](themes/amethyst-night.toml) | Image coming soon |

Preview images will be stored in [`assets/previews/`](assets/previews/). Until an image is available, each theme section includes a text representation of the prompt.

## Amethyst Night

Amethyst Night is a two-line Powerline-style prompt with a purple palette inspired by Dracula. It displays the operating system, user, hostname, directory, Git status, command duration, exit status, time, shell, and detected development tools.

Text preview:

```text
╭─ 󰣇  tirsasaki  󰒋 cachyos  󰉋 ~/Projects/demo  󰘬 main !
╰─❯
```

Included modules:

- Arch Linux, CachyOS, EndeavourOS, and generic Linux icons
- Git branch and working-tree status
- command duration and exit status
- Python, Node.js, Rust, Go, Docker, Kubernetes, Terraform, and AWS
- success, error, and Vim-mode indicators

Configuration: [`themes/amethyst-night.toml`](themes/amethyst-night.toml)

## Requirements

Install:

1. [Starship](https://starship.rs/guide/#step-1-install-starship)
2. Zsh
3. A [Nerd Font](https://www.nerdfonts.com/), such as JetBrainsMono Nerd Font or MesloLGS Nerd Font

Select the Nerd Font in your terminal emulator. Installing it without selecting it will leave some icons as empty boxes.

## Installation

### Clone the collection

```bash
git clone https://github.com/tirsasaki/starship-themes.git
cd starship-themes
```

Back up an existing Starship configuration before installing a theme:

```bash
[ -f ~/.config/starship.toml ] && \
  cp ~/.config/starship.toml ~/.config/starship.toml.backup
```

Copy the theme you want. For Amethyst Night:

```bash
mkdir -p ~/.config
cp themes/amethyst-night.toml ~/.config/starship.toml
```

### Download one theme

You can install a theme without cloning the repository. Replace `THEME` with a filename from the [theme catalog](#theme-catalog):

```bash
THEME="amethyst-night"
mkdir -p ~/.config
curl -fsSL \
  "https://raw.githubusercontent.com/tirsasaki/starship-themes/main/themes/${THEME}.toml" \
  -o ~/.config/starship.toml
```

## Enable Starship in Zsh

Add this line to `~/.zshrc`:

```zsh
eval "$(starship init zsh)"
```

Reload Zsh:

```bash
exec zsh
```

Opening a new terminal window also reloads the configuration.

## Switch themes

If you cloned the repository, copy another theme over the active configuration:

```bash
cp themes/THEME-NAME.toml ~/.config/starship.toml
exec zsh
```

Replace `THEME-NAME` with the filename listed in the catalog. For example:

```bash
cp themes/amethyst-night.toml ~/.config/starship.toml
exec zsh
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

## Update the collection

From the cloned repository:

```bash
git pull --ff-only
```

Updates do not overwrite `~/.config/starship.toml`. Copy the selected theme again when you want to apply its latest version:

```bash
cp themes/amethyst-night.toml ~/.config/starship.toml
exec zsh
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

If you created a backup during installation:

```bash
mv ~/.config/starship.toml.backup ~/.config/starship.toml
exec zsh
```

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
│   └── amethyst-night.toml
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
