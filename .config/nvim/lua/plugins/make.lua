return {
  {
    "stevearc/overseer.nvim",
    dependencies = { "folke/snacks.nvim" },
    keys = {
      { "<space>r", "<CMD>OverseerRun<CR>" },
      { "<leader>r", "<CMD>OverseerToggle<CR>" },
    },
    opts = {
      templates = { "builtin", "user" },
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

      overseer.add_template_hook({ module = "npm" }, function(task_defn)
        local cmd = task_defn.cmd
        if cmd and cmd[1] == "pnpm" and cmd[2] == "run" then
          table.insert(cmd, 3, "--sequential")
        end
      end)
    end,
  },
}
