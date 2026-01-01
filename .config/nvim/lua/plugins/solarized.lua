return {
  {
    "maxmx03/solarized.nvim",
    lazy = false,
    cond = function()
      return not vim.g.vscode
    end,
    config = function()
      require("solarized").setup({
        theme = "neo", -- or comment to use solarized default theme.
        on_highlights = function(colors, color)
          return {
            -- git diffの背景色を調整
            DiffAdd = { bg = "palegreen" },
            DiffDelete = { bg = "tomato" },
            DiffChange = { bg = "lightblue" },
            DiffText = { bg = "lightpink" },
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
