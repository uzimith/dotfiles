let mapleader = ","
inoremap jj <Esc>
" カーソルを表示行で移動する。論理行移動は<C-n>,<C-p>
noremap j gj
noremap k gk
noremap <Down> gj
noremap <Up>   gk

noremap <Space>h  ^
noremap <Space>l  $

nnoremap Y y$

" insert mode での移動
inoremap  <C-e> <END>
inoremap  <C-a> <HOME>

inoremap <C-n> <Down>
inoremap <C-p> <Up>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <silent> <C-d> <C-g>u<Del>

"<space>j, <space>kで画面送り
noremap J <C-f>
noremap <Space>j J
noremap K <C-b>
noremap <Space>k <Space>k

" 最後に編集された位置に移動
nnoremap gb '[
nnoremap gp ']

" 前回終了したカーソル行に移動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" F4でバッファを削除する
map <F4> <ESC>:bnext \| bdelete #<CR>
command! Bw :bnext \| bdelete #

"フレームサイズを怠惰に変更する
map <kPlus> <C-W>+
map <kMinus> <C-W>-

" 矩形選択で自由に移動する
set virtualedit+=block

"ビジュアルモード時vで行末まで選択
vnoremap v $h

" タブ
noremap tc :tabnew<CR>
set showtabline=2 " 常にタブラインを表示

" 検索
nnoremap <Leader>cd :lcd %:h<CR>

" very magic
nnoremap v/ /\v
nnoremap / /

"カーソル位置の単語を単語単位の検索文字列に設定
nnoremap <silent> *  :<C-u>call MySetSearch('""yiw', 'word')<CR>:let &hlsearch=&hlsearch<CR>
"カーソル位置の単語を非単語単位の検索文字列に設定
nnoremap <silent> g* :<C-u>call MySetSearch('""yiw')<CR>:let &hlsearch=&hlsearch<CR>
"カーソル位置から単語の末尾までを検索文字列に設定
nnoremap <silent> #  :<C-u>call MySetSearch('""ye')<CR>:let &hlsearch=&hlsearch<CR>

"文字列選択中なら選択文字列を検索レジスタに設定。
vnoremap <silent> * :<C-u>call MySetSearch('""vgvy')<CR>:let &hlsearch=&hlsearch<CR>
vnoremap <silent> # :<C-u>call MySetSearch('""vgvy')<CR>:let &hlsearch=&hlsearch<CR>

"検索ワードをセットする。
"何か追加パラメータが設定されていたら、単語単位検索に。
function! MySetSearch(cmd, ...)
  let saved_reg = @"
  if a:cmd != ''
    silent exec 'normal! '.a:cmd
  endif
  let pattern = escape(@", '\\/.*$^~[]')
  let pattern = substitute(pattern, '\n$', '', '')
  if a:0 > 0
    let pattern = '\<'.pattern.'\>'
  endif
  let @/ = pattern
  let @" = saved_reg
endfunction
