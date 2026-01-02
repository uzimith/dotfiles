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
            DiffAdd = { fg = colors.git_add, bg = color.lighten(colors.git_add, 70) },
            DiffChange = { fg = colors.git_modify, bg = color.lighten(colors.git_modify, 70) },
            DiffDelete = {
              fg = color.lighten(colors.git_delete, 70),
              bg = color.lighten(colors.git_delete, 70),
              reverse = true,
            },
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
