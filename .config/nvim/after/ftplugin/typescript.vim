nmap <buffer> <silent> gd :TSDef<cr>
nmap <buffer> <silent> gt :TSDoc<cr>
au FileType typescript nmap <buffer> <silent> gd :TSDef<cr>
au FileType typescript nmap <buffer> <silent> gt :TSDoc<cr>
setlocal sw=4 sts=4 ts=4 et
autocmd FileType typescript setlocal sw=4 sts=4 ts=4 et
