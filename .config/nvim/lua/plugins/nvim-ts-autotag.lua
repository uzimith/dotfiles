return {
  "windwp/nvim-ts-autotag",
  lazy = false,
  cond = function()
    return not vim.g.vscode
  end,
  config = function()
    require("nvim-ts-autotag").setup({})
  end,
}
