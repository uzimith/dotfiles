vim.g.mapleader = ","

local opts = { noremap = true }

vim.keymap.set('i', 'jj', '<ESC>', opts)

-- カーソルを表示行で移動する。論理行移動は<C-n>,<C-p>
vim.keymap.set('n', 'j', 'gj', opts)
vim.keymap.set('n', 'k', 'gk', opts)

vim.keymap.set('n', '<Space>h', '^', opts)
vim.keymap.set('n', '<Space>l', '$', opts)
vim.keymap.set('n', 'Y', 'y$', opts)
vim.keymap.set('v', '<Space>h', '^', opts)
vim.keymap.set('v', '<Space>l', '$', opts)
vim.keymap.set('v', 'Y', 'y$', opts)


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
vim.keymap.set('n', 'tc', ':tabnew<CR>', opts)
vim.keymap.set('n', 'tn', ':tabnext<CR>', opts)
vim.keymap.set('n', 'tp', ':tabprevious<CR>', opts)
vim.keymap.set('n', 't1', ':tabn 1<CR>', opts)
vim.keymap.set('n', 't2', ':tabn 2<CR>', opts)
vim.keymap.set('n', 't3', ':tabn 3<CR>', opts)
vim.keymap.set('n', 't4', ':tabn 4<CR>', opts)
vim.keymap.set('n', 't5', ':tabn 5<CR>', opts)
vim.keymap.set('n', 't6', ':tabn 6<CR>', opts)
vim.keymap.set('n', 't7', ':tabn 7<CR>', opts)
vim.keymap.set('n', 't8', ':tabn 8<CR>', opts)
vim.keymap.set('n', 't9', ':tabn 9<CR>', opts)

-- 検索
vim.keymap.set('n', '<Leader>cd', ':lcd %:h<CR>', opts)

vim.keymap.set('n', '<Leader>en', ':lnext<CR>', opts)
vim.keymap.set('n', '<Leader>ep', ':lprevious<CR>', opts)

vim.keymap.set('n', 'c.', ':q:k<CR>', opts)
vim.keymap.set('c', 'w!!', 'w !sudo tee > /dev/null %<CR> :e!<CR>', opts)

-- ビジュアルモード時vで行末まで選択
vim.keymap.set('v', 'v', '$h', opts)

vim.keymap.set('n', 'sn', ':cnext<CR><CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'sp', ':cprevious<CR><CR>', { noremap = true, silent = true })

-- if vim.g.vscode then
--   vim.keymap.set('n', 'u', 'u', { noremap = true, silent = true })
--   vim.keymap.set('n', 'p', 'p', { noremap = true, silent = true })
--   vim.keymap.set('n', '<C-r>', '<C-r>', { noremap = true, silent = true })
--   vim.keymap.set('v', 'y', 'y', { noremap = true, silent = true })
-- end
