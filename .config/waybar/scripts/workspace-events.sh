#!/usr/bin/env bash
set -eu

runtime_dir=${XDG_RUNTIME_DIR:-/run/user/$(id -u)}
instance=${HYPRLAND_INSTANCE_SIGNATURE:?Hyprland instance signature is unavailable}
event_socket="$runtime_dir/hypr/$instance/.socket2.sock"

while [ -S "$event_socket" ]; do
  while IFS= read -r event; do
    case "$event" in
      workspace\>*|workspacev2\>*|focusedmon\>*)
        pkill -RTMIN+8 -x waybar 2>/dev/null || true
        ;;
    esac
  done < <(socat -u "UNIX-CONNECT:$event_socket" - 2>/dev/null)

  sleep 0.25
done
