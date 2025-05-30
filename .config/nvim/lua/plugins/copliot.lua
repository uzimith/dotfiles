return {
  {
    "zbirenbaum/copilot.lua",
    -- "github/copilot.vim",
    lazy = false,
    cmd = "Copilot",
    event = "InsertEnter",
    cond = function()
      return not vim.g.vscode
    end,
    config = function()
      require("copilot").setup({})
    end,
  },
  {
    'gptlang/CopilotChat.nvim',
    lazy = false,
    dependencies = 'zbirenbaum/copilot.lua',
    cond = function()
      return not vim.g.vscode
    end,
  }
}
