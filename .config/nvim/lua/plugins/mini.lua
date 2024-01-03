return {
    {
      "echasnovski/mini.nvim",
      lazy = false,
      config = function()
        require("mini.comment").setup({})
        require("mini.pairs").setup({})
      end,
    },
  }
