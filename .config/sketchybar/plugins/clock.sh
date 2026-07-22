#!/bin/sh

# The $NAME variable is passed from sketchybar and holds the name of
# the item invoking this script:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

case "$(date '+%u')" in
  1) weekday='月' ;;
  2) weekday='火' ;;
  3) weekday='水' ;;
  4) weekday='木' ;;
  5) weekday='金' ;;
  6) weekday='土' ;;
  7) weekday='日' ;;
esac

sketchybar --set "$NAME" label="$(date '+%d/%m') (${weekday}) $(date '+%H:%M')"
