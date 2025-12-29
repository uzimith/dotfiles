return {
  -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  branch = 'main',
  build = ':TSUpdate',
  cond = function()
    return not vim.g.vscode
  end,
  config = function()
    require 'nvim-treesitter'.install {
      'bash',
      'css',
      'go',
      'xml',
      'html',
      'javascript',
      'json',
      'lua',
      'markdown',
      'python',
      'rust',
      'typescript',
      'yaml',
      'tsx',
      'terraform',
      'toml',
      'vim',
      'fish',
      'dockerfile',
      'markdown',
      'markdown_inline',
      'regex',
      'csv',
      'tsv',
    }
  end,
}
