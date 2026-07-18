#!/usr/bin/env bash
set -eu

killall waybar 2>/dev/null || true

listener="$HOME/.config/waybar/scripts/workspace-events.sh"
pid_file="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/waybar-workspace-events.pid"

if [ -r "$pid_file" ]; then
  old_pid=$(<"$pid_file")
  if [[ "$old_pid" =~ ^[0-9]+$ ]] && [ -r "/proc/$old_pid/cmdline" ] &&
    tr '\0' '\n' < "/proc/$old_pid/cmdline" | grep -Fxq "$listener"; then
    old_session=$(ps -o sid= -p "$old_pid" 2>/dev/null | tr -d ' ')
    if [ "$old_session" = "$old_pid" ]; then
      kill -- "-$old_pid" 2>/dev/null || true
    else
      kill "$old_pid" 2>/dev/null || true
    fi
  fi
fi

setsid "$listener" &
printf '%s\n' "$!" > "$pid_file"

exec waybar -c "$HOME/.config/waybar/config.jsonc" -s "$HOME/.config/waybar/style.css"
