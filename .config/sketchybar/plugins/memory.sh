#!/bin/sh

memory_usage="$(LC_ALL=C memory_pressure -Q 2>/dev/null | awk '/System-wide memory free percentage/ { gsub(/%/, "", $5); printf "%.0f%%", 100 - $5 }')"

sketchybar --set "$NAME" label="${memory_usage:-N/A}"
