vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.showmatch = true
vim.opt.cursorline = true
vim.helplang = 'ja'

vim.cmd('hi clear CursorLine')
vim.cmd('hi CursorLine gui=underline')
vim.cmd('highlight CursorLine ctermbg=black guibg=black')