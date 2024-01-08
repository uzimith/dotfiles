return {
  'notjedi/nvim-rooter.lua',
  lazy = false,
  config = function()
    require('nvim-rooter').setup {
      update_cwd = true,
      update_focused_file = {
        enable = true,
        update_cwd = true
      },
      rooter_patterns = { 'go.mod', 'build.gradle', 'Rakefile', '.git', '_darcs', '.hg', '.bzr', '.svn' },
      trigger_patterns = { '*' },
      exclude_filetypes = { 'ddu-ff' },
      manual = false,
      fallback_to_parent = true,
    }
  end
}
