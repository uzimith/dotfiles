set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp,shift-jis,default,latin
set scrolloff=5                  " スクロール時の余白確保
set textwidth=0                  " 一行に長い文章を書いていても自動折り返しをしない
set nobackup                     " バックアップ取らない
set noswapfile                   " スワップファイル作らない
set nowritebackup
set hidden                       " 編集中でも他のファイルを開けるようにする
set backspace=indent,eol,start   " バックスペースでなんでも消せるように
set formatoptions=lmoq           " テキスト整形オプション，マルチバイト系を追加
set vb t_vb=                     " ビープをならさない
set browsedir=buffer             " Exploreの初期ディレクトリ
set whichwrap=b,s,h,l,<,>,[,]    " カーソルを行頭、行末で止まらないようにする
set showcmd                      " コマンドをステータス行に表示
set showmode                     " 現在のモードを表示
set viminfo='50,<1000,s100,\"50  " viminfoファイルの設定
" set ambiwidth=double
set ignorecase
set smartcase
set hlsearch
set incsearch
set splitright
set display=lastline
set pumheight=10

filetype plugin on

" ターミナルでマウスを使用できるようにする
set mouse=a
set guioptions+=a

" クリップボードを共有
set clipboard=unnamed

" 他で書き換えられたら自動で読み直す
set autoread
augroup vimrc-checktime
  autocmd!
  autocmd WinEnter * checktime
augroup END

