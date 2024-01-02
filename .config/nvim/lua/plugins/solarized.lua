return {
    "craftzdog/solarized-osaka.nvim",
    event = "VimEnter",
    priority = 1000,
    cond = function()
      return not vim.g.vscode
    end,
    config = function()
      vim.opt.background = "light"
      if vim.g.vscode then
        vim.cmd.colorscheme ""
      else
        vim.cmd.colorscheme "solarized-osaka"
      end
    end,
  }
