return {
  'notjedi/nvim-rooter.lua',
  lazy = false,
  config = function()
    require('nvim-rooter').setup {
      rooter_patterns = { 'go.mod', 'build.gradle', 'Rakefile', 'tsconfig.json', '.git', '_darcs', '.hg', '.bzr', '.svn' },
      trigger_patterns = { '*' },
      manual = false,
      fallback_to_parent = true,
    }
  end
}
