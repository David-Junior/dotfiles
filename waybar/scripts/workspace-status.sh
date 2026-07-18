#!/usr/bin/env bash
set -eu

workspace_id=${1:?workspace id required}
label=${2:?workspace label required}
active_id=$(hyprctl -j activeworkspace 2>/dev/null | jq -r '.id // 0' 2>/dev/null || printf '0')

if [ "$active_id" = "$workspace_id" ]; then
  state="active"
else
  state="inactive"
fi

printf '{"text":"%s","class":"%s","tooltip":"Workspace %s"}\n' \
  "$label" "$state" "$workspace_id"
