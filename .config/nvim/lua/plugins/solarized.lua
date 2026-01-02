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
        variant = "spring",
        on_highlights = function(colors, color)
          return {
            DiffAdd = { bg = color.lighten(colors.git_add, 70), fg = colors.git_add },
            DiffChange = { bg = color.lighten(colors.git_modify, 70), fg = colors.git_modify },
            DiffDelete = { bg = color.lighten(colors.git_delete, 70), fg = color.lighten(colors.git_delete, 70) },
            DiffText = { fg = color.lighten(colors.cyan, 70), bg = colors.cyan, reverse = true },
          }
        end,
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
