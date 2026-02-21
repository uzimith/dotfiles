#!/bin/sh
target="$1"
tmp=$(mktemp -t yazi-cwd.XXXXXX)
yazi --cwd-file="$tmp"
if cwd=$(cat -- "$tmp") && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
  tmux send-keys -t "$target" "cd \"$cwd\"" Enter
  terminal-notifier -title "Yazi" -message "Changed directory to $cwd in tmux pane $target"
fi
rm -f -- "$tmp"
