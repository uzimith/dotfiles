function fish_user_key_bindings
  fish_vi_key_bindings

  bind -M default -m default sk peco_kill
  bind -M default -m insert sg peco_select_repository
  bind -M default -m insert sG peco_open_repository
  bind -M default -m insert sr peco_recent_directory
  bind -M default -m insert sm peco_select_history
  bind -M default -m default 's*' peco_ripgrep_vim
  bind -M default -m insert sd peco_ls

  bind -M insert -m default jj backward-char force-repaint
  bind -M default -m default \x20l end-of-line
  bind -M default -m default \x20h beginning-of-line
end
