return {
  {
    'utilyre/barbecue.nvim',
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    after = "nvim-web-devicons",
    config = function()
      require('barbecue').setup {
        theme = 'solarized',
      }
    end,
  }
}
