return {
  {
    "nvim-mini/mini.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    lazy = false,
    config = function()
      require("mini.comment").setup({})

      local ai = require("mini.ai")
      ai.setup({
        n_lines = 500,
        mappings = {
          -- Main textobject prefixes
          around = "a",
          inside = "i",

          -- Next/last variants
          -- NOTE: These override built-in LSP selection mappings on Neovim>=0.12
          -- Map LSP selection manually to use it (see `:h MiniAi.config`)
          around_next = "an",
          inside_next = "in",
          around_last = "al",
          inside_last = "il",

          -- Move cursor to corresponding edge of `a` textobject
          goto_left = "[t",
          goto_right = "]t",
        },
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
