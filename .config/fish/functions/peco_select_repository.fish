function  peco_select_repository
  ghq list -p | peco $peco_flags | read line; builtin cd $line
end
