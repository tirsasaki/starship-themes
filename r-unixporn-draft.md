# r/unixporn post draft — copy-paste ready

> HOW TO POST: r/unixporn is an image subreddit.
> 1. Create an **image post** and upload the preview PNGs from `assets/previews/`
>    (put `amethyst-night.png` first — it's the showcase theme).
> 2. Paste the **post title** below as the title.
> 3. Paste the **details comment** below as the first comment (required by the subreddit rules).
> Nothing here is posted automatically — you post it yourself from your own account.

---

## Post title

```
[OC] 8 Starship prompt themes — one-line installer (Amethyst Night, Wabi Sabi, Frostline, Ember Retro, Sakura Dawn, Void Circuit, Oceanic Pulse, Monochrome Orbit)
```

---

## Details comment

```
A set of 8 hand-built Starship prompt themes I've been collecting. Each one is a
single standalone TOML file — no dotfile surgery, just pick and install.

Install any theme with one command (interactive picker, Amethyst Night selected
by default):

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/tirsasaki/starship-themes/main/install.sh)"

Or install by name, no menu:

    curl -fsSL https://raw.githubusercontent.com/tirsasaki/starship-themes/main/install.sh | sh -s -- frostline

Repo: https://github.com/tirsasaki/starship-themes (MIT)

THE THEMES

1. Amethyst Night — two-line Powerline in a Dracula-inspired purple palette,
   dev context (Python, Node, Rust, Go, Docker, Terraform, AWS) on the right.
   The richest of the set.

2. Wabi Sabi — restrained two-line prompt, indigo/matcha/terracotta. Quiet and
   deliberate.

3. Frostline — compact ice-blue one-liner. Directory, git, runtime, duration —
   one row, nothing wasted.

4. Ember Retro — warm two-line prompt with amber CRT energy. Rust block for
   user@host, glowing amber directory.

5. Sakura Dawn — soft pink/lavender one-liner made for light or pastel
   terminal backgrounds.

6. Void Circuit — minimal near-black one-liner. Lime and cyan carry the signal.

7. Oceanic Pulse — developer dashboard: project + git on the left, runtimes,
   Docker, Kubernetes, duration on the right.

8. Monochrome Orbit — grayscale two-liner with one lavender accent. Built for
   low-color setups.

Details: CachyOS / KDE Plasma | Terminal: Kitty (JetBrainsMono Nerd Font) |
Shell: zsh | Prompt: Starship | Compositor: Wayland

All themes use Nerd Font icons and Starship's OS module (auto-detects your
distro). Previews are real screenshots, not mockups.
```

> Adjust the "Details:" line to match the machine the screenshots were taken on
> before posting.
