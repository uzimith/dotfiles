return {
  {
    "stevearc/overseer.nvim",
    dependencies = { "folke/snacks.nvim" },
    keys = {
      { "<space>r", "<CMD>OverseerRun<CR>" },
      { "<leader>r", "<CMD>OverseerToggle<CR>" },
    },
    opts = {
      task_list = {
        direction = "right",
        keymaps = {
          ["<CR>"] = { "keymap.open", opts = { dir = "float" }, desc = "Open task output in float" },
          ["<C-w>"] = { "keymap.run_action", opts = { action = "watch" } },
          ["r"] = { "keymap.run_action", opts = { action = "restart" } },
          ["a"] = "keymap.run_action",
        },
      },
      task_win = {
        padding = 2,
        border = "single",
        win_opts = {},
      },
    },
    config = function(_, opts)
      require("overseer").setup(opts)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "OverseerOutput",
        callback = function()
          vim.keymap.set("n", "q", "<CMD>quit<CR>", { buffer = true, nowait = true })
        end,
      })
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
