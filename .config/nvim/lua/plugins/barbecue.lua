return {
  {
    'utilyre/barbecue.nvim',
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    cond = function()
      return not vim.g.vscode
    end,
    lazy = false,
    after = "nvim-web-devicons",
    config = function()
      require('barbecue').setup {
        theme = 'solarized',
      }
    end,
  }
}
