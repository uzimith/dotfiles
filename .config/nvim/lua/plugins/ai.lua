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
    "coder/claudecode.nvim",
    lazy = false,
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
      { "<leader>c",  nil,                              desc = "AI/Claude Code" },
      { "<leader>cc", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
      { "<leader>cf", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
      { "<leader>cr", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },
      { "<leader>cC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>cm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer" },
      { "<leader>cs", "<cmd>ClaudeCodeSend<cr>",        mode = "v",                  desc = "Send to Claude" },
      {
        "<leader>cs",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      -- Diff management
      { "<leader>ca", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>cd", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
    },
  }

}
