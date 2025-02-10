return {
  {
    "github/copilot.vim",
    event = "InsertEnter",
    cmd = "Copilot",
    cond = function()
      return not vim.g.vscode
    end,
    ft = {
      "markdown",
      "help",
    },
  },
  {
    'gptlang/CopilotChat.nvim',
    dependencies = 'github/copilot.vim',
    cmd = "CopilotChat",
    cond = function()
      return not vim.g.vscode
    end,
  }
}
