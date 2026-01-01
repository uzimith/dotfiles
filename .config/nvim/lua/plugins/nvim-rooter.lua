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
      manual = true,
      fallback_to_parent = true,
    })

    vim.api.nvim_create_autocmd("VimEnter", {
      group = vim.api.nvim_create_augroup("user.rooter.vimenter", { clear = true }),
      callback = function()
        if vim.fn.argc() > 0 then
          vim.cmd("Rooter")
        end
      end,
    })
  end,
}
