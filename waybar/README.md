# Portable Waybar setup (Arch + Hyprland)

This is the structure of the current bar without the ML4W framework or
package-update counter. Its five workspace buttons use the Japanese numerals
`一` through `五`.

The broader visual system and application theming recommendations are documented
in [THEMING_GUIDE.md](THEMING_GUIDE.md).

## 1. Install packages

Install the core bar and the programs used by its buttons:

```bash
sudo pacman -S --needed waybar btop networkmanager network-manager-applet \
  pipewire wireplumber pipewire-pulse pavucontrol bluez bluez-utils \
  swaync hyprlock libnotify power-profiles-daemon brightnessctl playerctl \
  ttf-jetbrains-mono-nerd
```

`wlogout` and the Material Symbols font are in the AUR rather than the official
Arch repositories. Install them with your AUR helper, for example:

```bash
yay -S wlogout ttf-material-symbols-variable-git
```

You also need one terminal emulator. The helper automatically detects Kitty, Foot, Alacritty, WezTerm, or Ghostty. For example:

```bash
sudo pacman -S --needed kitty
```

Notes:

- `nmtui` comes from `networkmanager`; right-clicking the network module uses `nm-connection-editor` from `network-manager-applet`.
- Audio scrolling and mute use WirePlumber's `wpctl`; clicking opens `pavucontrol`.
- The Bluetooth click opens `bluetoothctl` in a terminal.
- Notification actions require `swaync`; power and lock actions require `wlogout` and `hyprlock`.
- The battery module simply stays hidden on a desktop without a battery.

Enable services needed by NetworkManager and Bluetooth:

```bash
sudo systemctl enable --now NetworkManager.service
sudo systemctl enable --now bluetooth.service
systemctl --user enable --now pipewire.socket pipewire-pulse.socket wireplumber.service
```

The user audio services are normally socket-activated, so an "already active" message is harmless.

## 2. Copy the files

Copy the *contents* of this directory into `~/.config/waybar` on the new machine:

```bash
mkdir -p ~/.config/waybar
cp -r config.jsonc style.css launch.sh scripts ~/.config/waybar/
chmod +x ~/.config/waybar/launch.sh ~/.config/waybar/scripts/terminal-run.sh \
  ~/.config/waybar/scripts/workspace-status.sh ~/.config/waybar/scripts/workspace-events.sh \
  ~/.config/waybar/scripts/cpu-status.sh
```

If copying from another machine, `rsync` is convenient:

```bash
rsync -av portable-waybar/ user@new-machine:~/.config/waybar/
```

## 3. Start it with Hyprland

Add this to `~/.config/hypr/hyprland.conf`:

```ini
exec-once = swaync
exec-once = ~/.config/waybar/launch.sh
```

Then reload Hyprland or run `~/.config/waybar/launch.sh` manually.

## Controls retained

| Module | Action |
| --- | --- |
| Workspaces | Click to switch; scroll to move relatively |
| Media | Left click play/pause; middle click previous; right click next |
| Power profile | Click to cycle through the available power profiles |
| Brightness | Hover for the percentage; scroll to adjust it |
| Volume | Hover for the percentage; scroll to adjust; left click mixer; right click mute |
| Network | Hover for the network name; left click `nmtui`; right click connection editor |
| Network | Left click `nmtui`; right click connection editor |
| Bluetooth | Left click `bluetoothctl` |
| Hardware drawer | Hover to reveal disk, CPU, and memory; click a reading for `btop` |
| Notifications | Left click panel; right click do-not-disturb |
| Power | Left click `wlogout`; right click `hyprlock` |
| Clock | Right click toggles Waybar's alternate date format |

Terminal tools launched from the bar open as centered floating windows under
Hyprland. Regular terminal windows continue to use the normal tiled layout.

The five workspace buttons use explicit Hyprland Lua dispatchers for compatibility
with Lua-based Hyprland configurations. A small event-socket listener refreshes
their active state immediately when the focused workspace changes.
