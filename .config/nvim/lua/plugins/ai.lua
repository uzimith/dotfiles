return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    cond = function()
      return not vim.g.vscode
    end,
    config = function()
      vim.g.copilot_node_command = "~/.local/share/mise/installs/node/22.13.1/bin/node"
      require("copilot").setup({
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept = false,
            next = "<M-]>",
            prev = "<M-[>",
            accept_word = "<M-Right>",
            accept_line = "<M-Down>",
          },
        },
      })
      vim.keymap.set("i", "<Tab>", function()
        if require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").accept()
          return ""
        else
          return "<Tab>"
        end
      end, { expr = true })
    end,
  },
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    lazy = false,
    cond = function()
      return not vim.g.vscode
    end,
    opts = {
      diff_opts = {
        open_in_current_tab = false,
      },
    },
    keys = {
      {
        "<leader>a",
        function()
          vim.fn.setreg("+", "@" .. vim.fn.expand("%:."))
        end,
        desc = "Copy buffer path",
      },
    },
  },
}
