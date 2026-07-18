#!/usr/bin/env bash
set -eu

if [ "$#" -eq 0 ]; then
  exit 2
fi

launch_popup() {
  if command -v hyprctl >/dev/null 2>&1 && [ -n "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]; then
    local command_string
    local lua_command
    printf -v command_string '%q ' "$@"
    lua_command=${command_string//\\/\\\\}
    lua_command=${lua_command//\"/\\\"}

    if hyprctl dispatch \
      "hl.dsp.exec_cmd(\"${lua_command}\", { float = true, size = { 900, 600 }, center = true })"; then
      exit 0
    fi
  fi

  exec "$@"
}

if [ -n "${TERMINAL:-}" ] && command -v "$TERMINAL" >/dev/null 2>&1; then
  launch_popup "$TERMINAL" -e "$@"
fi

for terminal in kitty foot alacritty wezterm ghostty; do
  if command -v "$terminal" >/dev/null 2>&1; then
    if [ "$terminal" = "kitty" ]; then
      launch_popup kitty --class waybar-popup --title "Waybar Utility" -e "$@"
    fi
    launch_popup "$terminal" -e "$@"
  fi
done

notify-send "Waybar" "No supported terminal found. Set the TERMINAL environment variable."
exit 1
