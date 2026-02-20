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
      vim.cmd.cnoreabbrev("OS OverseerShell")

      overseer.add_template_hook({ module = "npm" }, function(task_defn)
        local cmd = task_defn.cmd
        if cmd and cmd[1] == "pnpm" and cmd[2] == "run" then
          table.insert(cmd, 3, "--sequential")
        end
      end)
    end,
  },
}
