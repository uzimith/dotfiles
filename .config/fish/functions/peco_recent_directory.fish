function peco_recent_directory
    z -l | peco | awk '{ print $2 }' | read recent; builtin cd $recent
end
