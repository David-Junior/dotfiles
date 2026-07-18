# Solitude dotfiles

A compact, monochrome Hyprland desktop built around deep charcoal surfaces,
steel-gray structure, sharp geometry, and restrained ember-orange accents.

This setup is directly inspired by
[HANCORE Linux's Omarchy Solitude theme](https://github.com/HANCORE-linux/omarchy-solitude-theme).
Its palette, wallpapers, and application themes provided the visual foundation;
the Waybar layout, Material Symbols icon system, interaction patterns, SwayNC,
SwayOSD, wlogout, GTK overrides, and standalone Hyprlock configuration were
adapted for this machine.

## Design language

- Background: `#101315`
- Foreground: `#cacccc`
- Structure: `#343d41`
- Muted steel: `#798186`
- Active focus: `#a8adb0`
- Critical accent: `#de6145`
- Sharp corners, thin borders, minimal shadows
- Orange is semantic: warnings, errors, and destructive actions

## Included configuration

| Component | Purpose |
| --- | --- |
| Hyprland | compositor, window rules, keybindings, and autostart |
| Waybar | compact status bar with centered clock and hover drawers |
| Fuzzel | sharp application launcher |
| Kitty | monochrome terminal palette with semantic orange warnings |
| Neovim | LazyVim with the Ashen colorscheme |
| btop | Solitude system-monitor theme |
| SwayNC | notifications and control center |
| SwayOSD | volume and brightness feedback |
| Hyprlock | wallpaper-backed lock screen |
| wlogout | power menu launched from Waybar |
| GTK 3/4 | Solitude palette and sharp controls |

The repository also includes the six Solitude wallpapers and the local
steel-gray SVG assets used by wlogout.

## Packages

Official Arch packages are listed in [`packages/pacman.txt`](packages/pacman.txt),
and AUR packages in [`packages/aur.txt`](packages/aur.txt).

Install them with:

```bash
sudo pacman -S --needed - < packages/pacman.txt
yay -S --needed - < packages/aur.txt
```

## Installation

Back up existing configuration first. Then copy only the components you want:

```bash
git clone https://github.com/David-Junior/dotfiles.git
cp -a dotfiles/.config/waybar ~/.config/
cp -a dotfiles/.config/hypr ~/.config/
```

Repeat for the other directories rather than copying all of `.config` blindly.
Some settings contain absolute paths under `/home/david`; adjust those paths for
a different username.

The GTK icon theme is selected through dconf:

```bash
gsettings set org.gnome.desktop.interface icon-theme 'Yaru-sage-dark'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
```

## Useful bindings

| Binding | Action |
| --- | --- |
| `Super + Return` | Open Kitty |
| `Super + R` | Open Fuzzel |
| `Super + L` | Lock with Hyprlock |
| `Print` | Select a region and copy the screenshot to the clipboard |

Volume and brightness keys display SwayOSD feedback and remain available while
the screen is locked.

## Attribution

Visual direction, palette, wallpapers, and several base application themes are
derived from
[omarchy-solitude-theme](https://github.com/HANCORE-linux/omarchy-solitude-theme)
by HANCORE Linux. Ashen for Neovim is maintained separately at
[ficd0/ashen.nvim](https://github.com/ficd0/ashen.nvim).

Please consult the upstream projects for their respective asset and software
licenses.
