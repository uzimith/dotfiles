set -x SSH_AGENT_FILE $HOME/.ssh/ssh-agent
if test -f $SSH_AGENT_FILE
    source $SSH_AGENT_FILE
end
ssh-add -l >/dev/null ^&1
if test $status -ne 0
    ssh-agent -c >$SSH_AGENT_FILE
    source $SSH_AGENT_FILE
end

# WSL
set -gx DISPLAY (cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0.0
alias explorer="/mnt/c/Windows/explorer.exe"
set -gx PATH $PATH "/mnt/c/Program Files/Docker/Docker/resources/bin"
