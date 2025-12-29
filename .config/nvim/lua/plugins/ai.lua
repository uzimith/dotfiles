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
      { "<leader>a", function() vim.fn.setreg('+', '@' .. vim.fn.expand('%:.')) end, desc = "Copy buffer path" },
    },
  }

}
