#!/bin/sh
target="$1"
cwd_tmp=$(mktemp -t yazi-cwd.XXXXXX)
chooser_tmp=$(mktemp -t yazi-chooser.XXXXXX)
yazi --cwd-file="$cwd_tmp" --chooser-file="$chooser_tmp"

if [ -s "$chooser_tmp" ]; then
  chosen=$(head -1 "$chooser_tmp")
  pane_cmd=$(tmux display-message -t "$target" -p '#{pane_current_command}')
  is_vim=$(printf '%s' "$pane_cmd" | grep -iqE '(view|n?vim?x?)(diff)?$' && echo 1 || echo 0)
  is_node=$(printf '%s' "$pane_cmd" | grep -iqE '^node$' && echo 1 || echo 0)
  if [ "$is_vim" = "1" ]; then
    tmux send-keys -t "$target" Escape ":edit $chosen" Enter
  elif [ "$is_node" = "1" ]; then
    tmux send-keys -t "$target" "@$chosen "
  else
    tmux send-keys -t "$target" "nvim \"$chosen\"" Enter
  fi
elif cwd=$(cat -- "$cwd_tmp") && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
  tmux send-keys -t "$target" "cd \"$cwd\"" Enter
fi

rm -f -- "$cwd_tmp" "$chooser_tmp"
