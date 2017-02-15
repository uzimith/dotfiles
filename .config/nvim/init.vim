let g:python_host_prog = expand('/usr/local/bin/python')
let g:python3_host_prog = expand('/usr/local/bin/python3')

source ~/.config/nvim/basic.vim
source ~/.config/nvim/apperance.vim
source ~/.config/nvim/key.vim
source ~/.config/nvim/indent.vim
source ~/.config/nvim/bundle.vim

if filereadable( $HOME . "/.config/nvim/secret.vim" )
  source ~/.config/nvim/secret.vim
endif
