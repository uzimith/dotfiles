set -gx XDG_CONFIG_HOME $HOME/.config
set -gx LANG 'ja_JP.UTF-8'
set -gx LC_ALL 'ja_JP.UTF-8'
set -gx EDITOR vim

##
# PATH
##

# homebrew
set -gx PATH /usr/local/bin $PATH
# haskell
#set -gx PATH $HOME/.cabal/bin $PATH
#set -gx PATH $HOME/Library/Haskell/bin $PATH
# nodebrew
#set -gx PATH $HOME/.nodebrew/current/bin $PATH
# my bin
set -gx PATH $XDG_CONFIG_HOME/bin $PATH
# Go
set -gx GOPATH $HOME
set -gx PATH $PATH $GOPATH/bin

#Android SDK
#set -gx PATH $PATH ~/Library/Android/sdk/platform-tools
#set -gx PATH $PATH ~/Library/Android/sdk/tools
#set -gx ANDROID_HOME $PATH ~/Library/Android/sdk

# Google Cloud SDK
set fish_user_paths /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin
set -x MANPATH /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/help/man /usr/local/share/man /usr/share/man /opt/x11/share/man

#rbenv
rbenv init - | source

##
# alias
##

alias vim='nvim'
alias l='ll | peco'
alias rgf='ripgrep_glob'
alias prg='peco_ripgrep_vim'

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

# application
alias firefox="open -a Firefox"
alias safari="open -a Safari"
alias itunes="open -a iTunes"
alias prev="open -a Preview"
alias vlc="open -a VLC.app"

##
# powerline
##

powerline-daemon -q
set fish_function_path $fish_function_path "/usr/local/lib/python2.7/site-packages/powerline/bindings/fish"
powerline-setup
function fish_mode_prompt; end # fishのmodeを非表示

##
# mac
##

alias wifilist='networksetup -listallhardwareports'
alias wifiget='networksetup -getairportnetwork en0'
alias wifiset='networksetup -setairportnetwork en0'
alias wifipower='networksetup -setairportpower en0'
