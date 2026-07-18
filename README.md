# Dotfiles

My personal configuration backup for Hyprland and the applications around it.

Tracked configuration:

- Hyprland, Hyprpaper, and Hyprlock
- Waybar and Fuzzel
- Kitty and Neovim
- btop
- SwayNC and SwayOSD
- wlogout
- GTK 3 and GTK 4 overrides

The desktop uses dark monochrome surfaces, sharp edges, a centered Waybar
clock, hover-reveal modules, and small orange accents for warnings and critical
actions.

Package lists are in [`packages/pacman.txt`](packages/pacman.txt) and
[`packages/aur.txt`](packages/aur.txt).

```bash
sudo pacman -S --needed - < packages/pacman.txt
yay -S --needed - < packages/aur.txt
```

To back up changes:

```bash
cd ~/.config
git add -A
git commit -m "describe the change"
git push
```

This setup was inspired by
[HANCORE Linux's Omarchy Solitude theme](https://github.com/HANCORE-linux/omarchy-solitude-theme)
and personalized with Codex.
