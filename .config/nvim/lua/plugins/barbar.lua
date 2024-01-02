return {
    'romgrk/barbar.nvim',
    lazy = false,
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'lewis6991/gitsigns.nvim',
    },
    init = function() vim.g.barbar_auto_setup = false end,
    config = function()
    end
  }