return {
  {
    "stevearc/overseer.nvim",
    dependencies = { "folke/snacks.nvim" },
    keys = {
      { "<space>r", "<CMD>OverseerRun<CR>" },
      { "<leader>r", "<CMD>OverseerToggle<CR>" },
    },
    opts = {
      actions = {
        -- https://github.com/stevearc/overseer.nvim/blob/3cde0d84bdae56cd119cbf835f764fa30cec384c/lua/overseer/task_list/actions.lua#L175-L194
        ["quickfix and close"] = {
          desc = "open the entire task output in quickfix",
          condition = function(task)
            local bufnr = task:get_bufnr()
            return task:is_complete()
              and bufnr ~= nil
              and vim.api.nvim_buf_is_valid(bufnr)
              and vim.api.nvim_buf_is_loaded(bufnr)
          end,
          run = function(task)
            local lines = vim.api.nvim_buf_get_lines(assert(task:get_bufnr()), 0, -1, true)
            vim.fn.setqflist({}, " ", {
              title = task.name,
              lines = lines,
              -- Peep into the default component params to fetch the errorformat
              ---@diagnostic disable-next-line: invisible
              efm = task.default_component_params.errorformat,
            })
            vim.cmd("botright copen")
            -- add: close
            vim.cmd("OverseerClose")
          end,
        },
      },
      task_list = {
        direction = "right",
        keymaps = {
          ["<CR>"] = { "keymap.open", opts = { dir = "float" }, desc = "Open task output in float" },
          ["<C-w>"] = { "keymap.run_action", opts = { action = "watch" } },
          ["r"] = { "keymap.run_action", opts = { action = "restart" } },
          ["a"] = "keymap.run_action",
          ["<C-q>"] = { "keymap.run_action", opts = { action = "quickfix and close" } },
        },
      },
      task_win = {
        padding = 2,
        border = "single",
        win_opts = {},
      },
    },
    config = function(_, opts)
      local overseer = require("overseer")
      overseer.setup(opts)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "OverseerOutput",
        callback = function()
          vim.keymap.set("n", "q", "<CMD>quit<CR>", { buffer = true, nowait = true })
        end,
      })

      -- pnpm run に --sequential を付ける（並列実行だと出力が混ざる）
      overseer.add_template_hook({ module = "npm" }, function(task_defn)
        vim.notify("Adding --sequential to pnpm run command", vim.log.levels.DEBUG)
        local cmd = task_defn.cmd
        if cmd and cmd[1] == "pnpm" and cmd[2] == "run" then
          table.insert(cmd, 3, "--sequential")
        end
      end)
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
