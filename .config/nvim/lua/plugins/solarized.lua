return {
  {
    "maxmx03/solarized.nvim",
    lazy = false,
    cond = function()
      return not vim.g.vscode
    end,

    config = function()
      require("solarized").setup({
        palette = "selenized",
        variant = "winter",
      })
      vim.opt.background = "light"
      if vim.g.vscode then
        vim.cmd.colorscheme("")
      else
        vim.cmd.colorscheme("solarized")
      end
    end,
  },
}
