return {
  {
    "github/copilot.vim",
    lazy = false,
    cmd = "Copilot",
    event = "InsertEnter",
    cond = function()
      return not vim.g.vscode
    end,
    config = function()
      vim.g.copilot_node_command = '~/.local/share/mise/installs/node/22.13.1/bin/node'
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" },                       -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken",                          -- Only on MacOS or Linux
    opts = {
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
