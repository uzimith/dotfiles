return {
  {
    'stevearc/quicker.nvim',
    lazy = false,
    config = function()
      local quicker = require("quicker")

      vim.keymap.set("n", "<leader>q", function()
        local qflist = vim.fn.getqflist()
        if #qflist == 0 then
          vim.notify("quickfix is empty", vim.log.levels.WARN)
          return
        end
        quicker.toggle({ height = 10 })
        quicker.close({ loclist = true })
      end, {
        desc = "Toggle quickfix",
      })
      vim.keymap.set("n", "<leader>l", function()
        local loclist = vim.fn.getloclist(0)
        if #loclist == 0 then
          vim.notify("loclist is empty", vim.log.levels.WARN)
          return
        end
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
