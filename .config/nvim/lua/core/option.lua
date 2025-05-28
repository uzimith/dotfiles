vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.showmatch = true
vim.opt.cursorline = true
vim.helplang = 'ja'

vim.opt.scrolloff = 5
vim.opt.textwidth = 0
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false
vim.opt.hidden = true
vim.opt.backspace = "indent,eol,start"
vim.opt.formatoptions = "lmoq"
-- ビープをならさない
vim.opt.visualbell = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.splitright = true
vim.opt.display = "lastline"
vim.opt.pumheight = 10
vim.opt.pumblend = 20
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand('~/.cache/nvim/undo')
vim.opt.shell = "/bin/bash"
if vim.g.vscode then
  vim.opt.cmdheight = 10
else
  vim.opt.cmdheight = 0
end


-- 不可視文字可視化
vim.opt.list = true
vim.opt.listchars = { tab = "▸ ", trail = "⋅", nbsp = "␣", extends = "❯", precedes = "❮" }

-- タブ, インデント
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true

-- 常にタブラインを表示
vim.opt.showtabline = 2

-- ターミナルでマウスを使用できるようにする
vim.opt.mouse = "a"

-- クリップボードを共有
vim.opt.clipboard = "unnamedplus"

-- 矩形選択で自由に移動する
vim.opt.virtualedit = "block"

-- 他で書き換えられたら自動で読み直す
vim.opt.autoread = true

vim.cmd([[
    let g:python3_host_prog = '/usr/bin/python3'
]])
