return {
  {
    "nvim-mini/mini.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    lazy = false,
    config = function()
      require("mini.comment").setup({})
      require("mini.pairs").setup({})

      local ai = require("mini.ai")
      ai.setup({
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          f = ai.gen_spec.treesitter({
            a = "@function.outer",
            i = "@function.inner",
          }),
          c = ai.gen_spec.treesitter({
            a = "@class.outer",
            i = "@class.inner",
          }),
        },
      })
    end,
  },
}
