" filetype off
" filetype plugin indent off
filetype plugin indent on

if has("mac")
  let g:python3_host_prog = expand('/opt/homebrew/bin/python3')
elseif has("unix")
  let g:python3_host_prog = expand('/usr/bin/python')
elseif has("win64")
elseif has("win32unix")
elseif has("win32")
endif

source ~/.config/nvim/basic.vim
source ~/.config/nvim/apperance.vim
source ~/.config/nvim/key.vim
source ~/.config/nvim/indent.vim
source ~/.config/nvim/bundle.vim

if filereadable( $HOME . "/.config/nvim/secret.vim" )
  source ~/.config/nvim/secret.vim
endif

filetype plugin indent on
syntax enable
