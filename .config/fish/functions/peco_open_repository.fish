function  peco_open_repository
  ghq list -p | peco | read line; gh-open $line
end
