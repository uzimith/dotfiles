nmap <buffer> <silent> gd <Plug>(rust-def)
nmap <buffer> <silent> gt <Plug>(rust-doc)
au BufRead,BufNewFile *.rs nmap <buffer> <silent> gd <Plug>(rust-def)
au BufRead,BufNewFile *.rs nmap <buffer> <silent> gt <Plug>(rust-doc)
