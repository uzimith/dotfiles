return {
  "notjedi/nvim-rooter.lua",
  lazy = false,
  cond = function()
    return not vim.g.vscode
  end,
  config = function()
    require("nvim-rooter").setup({
      update_cwd = true,
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
      rooter_patterns = {
        "package.json",
        "go.mod",
        "build.gradle",
        "Rakefile",
        ".git",
        "_darcs",
        ".hg",
        ".bzr",
        ".svn",
      },
      trigger_patterns = { "*" },
      exclude_filetypes = {
        "ddu-ff",
        "ddu-ff-filter",
        "ddu-filer",
        "dropbar_menu",
        "dropbar_menu_fzf",
        "dropbar_preview",
        "oil",
      },
      manual = false,
      fallback_to_parent = true,
    })
  end,
}
