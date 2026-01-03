return {
  {
    "stevearc/overseer.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {},
    config = function(_, opts)
      local overseer = require("overseer")
      overseer.setup(opts)

      -- ddu-vim-ui-select は denops 経由のため Lua 関数がシリアライズできない
      -- overseer のテンプレートには builder 関数が含まれるため、snacks.picker を使う
      vim.api.nvim_create_user_command("OverseerRunNative", function()
        local original_select = vim.ui.select
        vim.ui.select = require("snacks.picker.select").select
        overseer.run_task({}, function()
          vim.ui.select = original_select
        end)
      end, {})

      vim.keymap.set("n", "<leader>e", overseer.toggle, { noremap = true })
    end,
  },
  -- {
  --   "nvim-neotest/neotest",
  --   dependencies = {
  --     "nvim-neotest/nvim-nio",
  --     "nvim-lua/plenary.nvim",
  --     "antoinemadec/FixCursorHold.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --     "marilari88/neotest-vitest",
  --   },
  --   config = function()
  --     vim.keymap.set("n", "<leader>tc", function()
  --       vim.fn.setqflist({}, "r") -- クリア
  --       vim.cmd("copen")
  --       vim.fn.jobstart("pnpm --filter web-crawler check:type", {
  --         stdout_buffered = true,
  --         stderr_buffered = true,
  --         on_stdout = function(_, data)
  --           local items = {}
  --           for _, line in ipairs(data) do
  --             local file, row, col, msg = line:match("^(.+)%((%d+),(%d+)%): (.+)$")
  --             if file then
  --               table.insert(items, {
  --                 filename = file,
  --                 lnum = tonumber(row),
  --                 col = tonumber(col),
  --                 text = msg,
  --               })
  --             end
  --           end
  --           vim.fn.setqflist(items, "a")
  --         end,
  --       })
  --     end)
  --
  --     require("neotest").setup({
  --       adapters = {
  --         require("neotest-vitest")({
  --           filter_dir = function(name)
  --             return name ~= "node_modules"
  --           end,
  --         }),
  --       },
  --     })
  --   end,
  -- },
}
