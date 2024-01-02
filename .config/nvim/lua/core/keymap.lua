vim.g.mapleader = ","

local opts = { noremap = true }

vim.keymap.set('i', 'jj', '<ESC>', opts)

-- カーソルを表示行で移動する。論理行移動は<C-n>,<C-p>
vim.keymap.set('n', 'j', 'gj', opts)
vim.keymap.set('n', 'k', 'gk', opts)

vim.keymap.set('n', '<Space>h', '^', opts)
vim.keymap.set('n', '<Space>l', '$', opts)
vim.keymap.set('n', 'Y', 'y$', opts)