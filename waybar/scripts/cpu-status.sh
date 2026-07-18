#!/usr/bin/env bash
set -eu

read_sample() {
  awk '
    /^cpu[0-9]* / {
      total = 0
      for (i = 2; i <= NF; i++) total += $i
      idle = $5 + $6
      print $1, total, idle
    }
  ' /proc/stat
}

mapfile -t before < <(read_sample)
sleep 0.12
mapfile -t after < <(read_sample)

tooltip=""
overall=0

for index in "${!after[@]}"; do
  read -r name total idle <<<"${after[$index]}"
  read -r _ previous_total previous_idle <<<"${before[$index]}"
  total_delta=$((total - previous_total))
  idle_delta=$((idle - previous_idle))

  if [ "$total_delta" -gt 0 ]; then
    usage=$(((100 * (total_delta - idle_delta) + total_delta / 2) / total_delta))
  else
    usage=0
  fi

  if [ "$name" = "cpu" ]; then
    overall=$usage
    printf -v tooltip 'Total:   %3d%%\n\nCores:' "$usage"
  else
    core=${name#cpu}
    printf -v row '\nCore %2d: %3d%%' "$core" "$usage"
    tooltip+=$row
  fi
done

jq -cn --arg text "$overall" --arg tooltip "$tooltip" \
  '{text: $text, tooltip: $tooltip}'
