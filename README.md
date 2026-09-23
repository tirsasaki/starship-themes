# Amethyst Night for Starship

A purple Powerline-style prompt for [Starship](https://starship.rs), inspired by the Dracula color palette.

Amethyst Night uses a compact two-line layout with Nerd Font icons. It shows the operating system, user, hostname, working directory, Git state, command duration, exit status, time, shell, and detected development tools.

## Preview

```text
╭─ 󰣇  tirsasaki  󰒋 cachyos  󰉋 ~/Projects/demo  󰘬 main !
╰─❯
```

Colors and icons depend on your terminal and font.

## Features

- Dracula-inspired purple palette
- two-line Powerline-style prompt
- Arch Linux, CachyOS, EndeavourOS, and generic Linux icons
- Git branch and working-tree status
- command duration and exit status
- right-side modules for time, shell, and development tools
- Python, Node.js, Rust, Go, Docker, Kubernetes, Terraform, and AWS modules
- success, error, and Vim-mode indicators

## Requirements

Install:

1. [Starship](https://starship.rs/guide/#step-1-install-starship)
2. Zsh
3. A [Nerd Font](https://www.nerdfonts.com/), such as JetBrainsMono Nerd Font or MesloLGS Nerd Font

Select the Nerd Font in your terminal emulator. Installing it without selecting it will leave some icons as empty boxes.

## Installation

### Automatic installation

Clone the repository and copy the theme:

```bash
git clone https://github.com/tirsasaki/amethyst-night-starship.git
cd amethyst-night-starship
mkdir -p ~/.config
cp themes/amethyst-night.toml ~/.config/starship.toml
```

If you already have a Starship configuration, back it up first:

```bash
cp ~/.config/starship.toml ~/.config/starship.toml.backup
```

### Download only the theme

```bash
mkdir -p ~/.config
curl -fsSL \
  https://raw.githubusercontent.com/tirsasaki/amethyst-night-starship/main/themes/amethyst-night.toml \
  -o ~/.config/starship.toml
```

The raw URL becomes available after the pull request is merged into `main`.

## Enable Starship in Zsh

Add this line to `~/.zshrc`:

```zsh
eval "$(starship init zsh)"
```

Reload Zsh:

```bash
exec zsh
```

You can also open a new terminal window.

## Verify the configuration

Check that Starship can parse the theme:

```bash
starship print-config >/dev/null && echo "Amethyst Night loaded"
```

Check the installed versions:

```bash
starship --version
zsh --version
```

## Update

From the cloned repository:

```bash
git pull --ff-only
cp themes/amethyst-night.toml ~/.config/starship.toml
exec zsh
```

## Customize

Edit:

```text
~/.config/starship.toml
```

The palette is under `[palettes.amethyst_night]`. For example, change the main purple color with:

```toml
purple = '#BD93F9'
```

To hide the hostname on local sessions and show it only over SSH:

```toml
[hostname]
ssh_only = true
```

To return to a one-line prompt, replace the top-level `format` value with your preferred Starship format.

## Restore the previous configuration

If you created a backup during installation:

```bash
mv ~/.config/starship.toml.backup ~/.config/starship.toml
exec zsh
```

To remove the theme without restoring another configuration:

```bash
rm ~/.config/starship.toml
exec zsh
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

### The prompt reports a configuration error

Run:

```bash
starship print-config
```

Starship will print the parsing error and its location. Replace the local file with an unmodified copy of `themes/amethyst-night.toml` if needed.

## License

Amethyst Night is available under the [MIT License](LICENSE).
