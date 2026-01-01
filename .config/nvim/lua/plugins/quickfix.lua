return {
  {
    "stevearc/quicker.nvim",
    lazy = false,
    config = function()
      local quicker = require("quicker")

      vim.keymap.set("n", "<leader>q", function()
        quicker.toggle({ height = 10 })
        quicker.close({ loclist = true })
      end, {
        desc = "Toggle quickfix",
      })
      vim.keymap.set("n", "<leader>w", function()
        quicker.toggle({
          height = 10,
          loclist = true,
        })
        quicker.close()
      end, {
        desc = "Toggle loclist",
      })

      quicker.setup({
        keys = {
          {
            ">",
            function()
              quicker.expand({ before = 2, after = 2, add_to_existing = true })
            end,
            desc = "Expand quickfix context",
          },
          {
            "<",
            function()
              quicker.collapse()
            end,
            desc = "Collapse quickfix context",
          },
          {
            "r",
            function()
              quicker.refresh()
            end,
            desc = "Refresh quickfix list",
          },
        },
      })
    end,
  },
}
