vim.g.mapleader = ","

local opts = { noremap = true }

vim.keymap.set('i', 'jj', '<ESC>', opts)

-- カーソルを表示行で移動する。論理行移動は<C-n>,<C-p>
vim.keymap.set('n', 'j', 'gj', opts)
vim.keymap.set('n', 'k', 'gk', opts)

vim.keymap.set('n', '<Space>h', '^', opts)
vim.keymap.set('n', '<Space>l', '$', opts)
vim.keymap.set('n', 'Y', 'y$', opts)


-- <space>j, <space>kで画面送り
vim.keymap.set('n', '<Space>j', 'J', opts)
vim.keymap.set('n', 'J', '<C-f>', opts)
vim.keymap.set('n', '<Space>k', 'K', opts)
vim.keymap.set('n', 'K', '<C-b>', opts)

-- 前回終了したカーソル行に移動
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	pattern = { "*" },
	callback = function()
		vim.api.nvim_exec('silent! normal! g`"zv', false)
	end,
})

-- タブ
vim.keymap.set('n', 'tC', ':tabnew<CR>', opts)

-- 検索
vim.keymap.set('n', '<Leader>cd', ':lcd %:h<CR>', opts)

vim.keymap.set('n', '<Leader>en', ':lnext<CR>', opts)
vim.keymap.set('n', '<Leader>ep', ':lprevious<CR>', opts)

vim.keymap.set('n', 'c.', ':q:k<CR>', opts)
vim.keymap.set('c', 'w!!', 'w !sudo tee > /dev/null %<CR> :e!<CR>', opts)
