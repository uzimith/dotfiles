return {
  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = { -- set to setup table
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    lazy = false,
    config = function()
      local highlight = {
        "Rainbow1",
        "Rainbow2",
      }

      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "Rainbow1", { fg = "#eeeeee" })
        vim.api.nvim_set_hl(0, "Rainbow2", { fg = "#ffffff" })
      end)
      require("ibl").setup({
        indent = {
          highlight = highlight,
        },
        scope = {
          highlight = highlight,
        },
      })
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },
}
