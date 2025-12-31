return {
  {
    'stevearc/quicker.nvim',
    lazy = false,
    config = function()
      local quicker = require("quicker")

      vim.keymap.set("n", "<leader>q", function()
        local ok = pcall(function()
          quicker.toggle({ height = 10 })
        end)
        if not ok then
          vim.notify("quickfix is empty or invalid", vim.log.levels.WARN)
        end
        pcall(function()
          quicker.close({ loclist = true })
        end)
      end, {
        desc = "Toggle quickfix",
      })
      vim.keymap.set("n", "<leader>l", function()
        local ok = pcall(function()
          quicker.toggle({
            height = 10,
            loclist = true,
          })
        end)
        if not ok then
          vim.notify("loclist is empty or invalid", vim.log.levels.WARN)
        end
        pcall(quicker.close)
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
