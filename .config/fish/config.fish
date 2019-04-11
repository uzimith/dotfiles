set -gx XDG_CONFIG_HOME $HOME/.config
set -gx LANG 'ja_JP.UTF-8'
set -gx LC_ALL 'ja_JP.UTF-8'
set -gx EDITOR vim
ulimit -n 4096

##
# PATH
##

# homebrew
set -gx PATH /usr/local/bin $PATH
set -gx PATH /usr/local/sbin $PATH
set -gx PATH /usr/local/opt/bison/bin $PATH

# haskell
#set -gx PATH $HOME/.cabal/bin $PATH
#set -gx PATH $HOME/Library/Haskell/bin $PATH
# nodebrew
#set -gx PATH $HOME/.nodebrew/current/bin $PATH
# my bin
set -gx PATH $XDG_CONFIG_HOME/bin $PATH
# Go
set -gx GOPATH $HOME
# set -gx GO111MODULE on
set -gx PATH $PATH $GOPATH/bin


# Rust
set -gx CARGO_HOME $HOME/.cargo
set -gx PATH $PATH $CARGO_HOME/bin
set -gx RUST_SRC_PATH (rustc --print sysroot)/lib/rustlib/src/rust/src

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

#rbenv
rbenv init - | source

#nodebrew
set -x PATH $HOME/.nodebrew/current/bin $PATH

#Java
set -x JAVA_HOME (/usr/libexec/java_home -v 1.8)

#GraalVM
# set GRAALVM_HOME ~/graalvm/Contents/Home/bin
# set -x PATH $GRAALVM_HOME $PATH
# set -x JAVA_HOME $GRAALVM_HOME

##
# alias
##

alias vim='nvim'
alias l='ll -a'
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
alias gd='git branch --merged | grep -v \'*\' | xargs git branch -d'

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

# aws
alias x-ebt='aws elasticbeanstalk describe-environments | jq -r ".Environments[] | [.EnvironmentName, .CNAME] | @tsv" | peco | cut -f 1 | xargs -I"{}" aws ec2 describe-instances --filters "Name=tag:elasticbeanstalk:environment-name,Values={}" | jq -r "[.Reservations[].Instances[].PrivateIpAddress] | map(select(.)) | .[]" | xpanes -c "ssh {}"'
alias open-ebt='aws elasticbeanstalk describe-environments | jq -r ".Environments[] | [.EnvironmentName, .ApplicationName, .EnvironmentId, .CNAME] | @tsv" | peco | awk \'{print sprintf("https://ap-northeast-1.console.aws.amazon.com/elasticbeanstalk/home?region=ap-northeast-1#/environment/dashboard?applicationName=%s&environmentId=%s", $2, $3)}\' | xargs open'
alias ebt='aws elasticbeanstalk describe-environments | jq -r ".Environments[] | [.EnvironmentName, .CNAME] | @tsv" | peco | cut -f 1 | xargs -I"{}" aws ec2 describe-instances --filters "Name=tag:elasticbeanstalk:environment-name,Values={}" | jq -r "[.Reservations[].Instances[].PrivateIpAddress] | map(select(.)) | .[]" | peco | read line; and ssh $line'

# powerline
##

powerline-daemon -q
set fish_function_path $fish_function_path "/usr/local/lib/python2.7/site-packages/powerline/bindings/fish"
powerline-setup
function fish_mode_prompt
end # fishのmodeを非表示

##
# mac
##

alias wifilist='networksetup -listallhardwareports'
alias wifiget='networksetup -getairportnetwork en0'
alias wifiset='networksetup -setairportnetwork en0'
alias wifipower='networksetup -setairportpower en0'

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/a14739/src/ghe.ca-tools.org/leicester/rush_test/mock/node_modules/tabtab/.completions/serverless.fish ]
and . /Users/a14739/src/ghe.ca-tools.org/leicester/rush_test/mock/node_modules/tabtab/.completions/serverless.fish
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/a14739/src/ghe.ca-tools.org/leicester/rush_test/mock/node_modules/tabtab/.completions/sls.fish ]
and . /Users/a14739/src/ghe.ca-tools.org/leicester/rush_test/mock/node_modules/tabtab/.completions/sls.fish

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/uzimith/google-cloud-sdk/path.fish.inc' ]
    if type source >/dev/null
        source '/Users/uzimith/google-cloud-sdk/path.fish.inc'
    else
        . '/Users/uzimith/google-cloud-sdk/path.fish.inc'
    end
end
