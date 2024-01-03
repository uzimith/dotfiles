return {
    'romgrk/barbar.nvim',
    lazy = false,
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'lewis6991/gitsigns.nvim',
    },
    init = function() vim.g.barbar_auto_setup = false end,
    config = function()
      require('bufferline').setup {
      }
      local opts = { noremap = true, silent = true }
      vim.keymap.set('n', 'tn', '<Cmd>BufferPrevious<CR>', opts)
      vim.keymap.set('n', 'tp', '<Cmd>BufferNext<CR>', opts)
      vim.keymap.set('n', 't1', '<Cmd>BufferGoto 1<CR>', opts)
      vim.keymap.set('n', 't2', '<Cmd>BufferGoto 2<CR>', opts)
      vim.keymap.set('n', 't3', '<Cmd>BufferGoto 3<CR>', opts)
      vim.keymap.set('n', 't4', '<Cmd>BufferGoto 4<CR>', opts)
      vim.keymap.set('n', 't5', '<Cmd>BufferGoto 5<CR>', opts)
      vim.keymap.set('n', 't6', '<Cmd>BufferGoto 6<CR>', opts)
      vim.keymap.set('n', 't7', '<Cmd>BufferGoto 7<CR>', opts)
      vim.keymap.set('n', 't8', '<Cmd>BufferGoto 8<CR>', opts)
      vim.keymap.set('n', 't9', '<Cmd>BufferGoto 9<CR>', opts)
      vim.keymap.set('n', 't0', '<Cmd>BufferLast<CR>', opts)
      vim.keymap.set('n', 'tc', '<Cmd>BufferClose<CR>', opts)
    end
  }
