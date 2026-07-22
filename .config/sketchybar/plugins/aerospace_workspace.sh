#!/bin/sh

workspace="${NAME#space.}"
focused_workspace="$(aerospace list-workspaces --focused 2>/dev/null)"
windows="$(aerospace list-windows --workspace "$workspace" --format '%{app-bundle-id}|%{app-name}' 2>/dev/null | sort -u)"
icons=""

while IFS='|' read -r bundle_id app_name; do
  [ -n "$bundle_id" ] || continue

  case "$bundle_id" in
    com.apple.finder) app_icon='' ;;
    com.google.Chrome) app_icon='' ;;
    com.mitchellh.ghostty) app_icon='' ;;
    com.spotify.client) app_icon='' ;;
    com.hnc.Discord) app_icon='' ;;
    com.tinyspeck.slackmacgap) app_icon='' ;;
    notion.id) app_icon='N' ;;
    *) app_icon="$(printf '%s' "$app_name")" ;;
  esac

  if [ -n "$app_icon" ]; then
    icons="${icons} ${app_icon}"
  else
    icons="$app_icon"
  fi
done <<EOF
$windows
EOF

label_padding_right=0
[ -n "$icons" ] && label_padding_right=20

if [ "$workspace" = "$focused_workspace" ]; then
  sketchybar --set "$NAME" \
    background.color=0x9a4a4d60 \
    background.border_color=0x80ffffff \
    label.padding_right="$label_padding_right" \
    label="$icons"
else
  sketchybar --set "$NAME" \
    background.color=0x6a282a36 \
    background.border_color=0x48ffffff \
    label.padding_right="$label_padding_right" \
    label="$icons"
fi
