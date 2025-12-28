set -gx XDG_CONFIG_HOME $HOME/.config

set -gx LC_ALL 'ja_JP.UTF-8'
set -gx EDITOR vim
ulimit -n 4096

##
# PATH
##

# homebrew
eval $(/opt/homebrew/bin/brew shellenv)

# clang
set -gx PATH /usr/local/opt/llvm/bin $PATH

# haskell
#set -gx PATH $HOME/.cabal/bin $PATH
#set -gx PATH $HOME/Library/Haskell/bin $PATH

# my bin
set -gx PATH $XDG_CONFIG_HOME/bin $PATH
set -gx PATH $HOME/.local/bin $PATH
# Go
set -gx GOPATH $HOME
# set -gx GO111MODULE on
set -gx PATH $PATH $GOPATH/bin

# Rust
set -gx CARGO_HOME $HOME/.cargo
set -gx PATH $PATH $CARGO_HOME/bin

#Android SDK
if test -d ~/Library/Android/sdk/
    set -gx PATH $PATH ~/Library/Android/sdk/platform-tools
    set -gx PATH $PATH ~/Library/Android/sdk/tools
    set -gx ANDROID_HOME $PATH ~/Library/Android/sdk
end

# Google Cloud SDK
if test -d /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin
    set fish_user_paths /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin
    set -x MANPATH /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/help/man /usr/local/share/man /usr/share/man /opt/x11/share/man
end

set -U fish_user_paths $fish_user_paths /usr/local/opt/openssl/bin

#flutter
set -gx PATH $PATH $HOME/flutter/bin

##
# alias
##

alias vim='nvim'
alias gcd='cd "$(git rev-parse --show-toplevel)"'
alias prg='peco_ripgrep_vim'
alias c='claude'
alias yolo='claude --dangerously-skip-permissions'

# docker
alias d='docker'
alias dc='docker-compose'

# process
alias j="jobs -l"
alias pk='pkill -f'

# du/df
alias du="du -h"
alias df="df -h"
alias duh="du -h ./ --max-depth=1"  

#finder
alias fo='open .'

#gem
alias be='bundle exec'
alias bi='bundle install --path .bundle'

# git
alias g='git'
alias t='tig'
alias ta='tig --all'
alias ts='tig status'
alias gd='git branch --merged | grep -v \'*\' | xargs git branch -d'

# kubectl
alias k='kubectl'
alias kc='kubectx | peco | xargs kubectx'
alias kn='kubens | peco | xargs kubens'

# util
alias cat='bat --paging=never'
alias ls="eza --icons --git"
alias la="eza -la --icons --git"
alias ll="eza -aahl --icons --git"
alias rgf='ripgrep_glob'
zoxide init fish --cmd cd | source

# application
alias firefox="open -a Firefox"
alias safari="open -a Safari"
alias itunes="open -a iTunes"
alias prev="open -a Preview"
alias vlc="open -a VLC.app"

# seq
alias seq1='seq -f "%01g"'
alias seq2='seq -f "%02g"'
alias seq3='seq -f "%03g"'
alias seq4='seq -f "%04g"'

# powerline
powerline-daemon -q
set fish_function_path $fish_function_path $HOME/dotfiles/powerline/powerline/bindings/fish
powerline-setup
function fish_mode_prompt
end # fishmode

switch (uname)
    case Linux
        source $HOME/.config/fish/linux.fish
    case Darwin
        source $HOME/.config/fish/mac.fish
end
source $HOME/.config/fish/secret.fish

/opt/homebrew/bin/mise activate fish | source
source "$HOME/.rye/env.fish"

# pnpm
set -gx PNPM_HOME "/Users/uzimith/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

# Added by Antigravity
fish_add_path /Users/uzimith/.antigravity/antigravity/bin

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
