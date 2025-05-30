return {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    event = { "BufReadPost", "BufNewFile" },
    branch = 'main',
    build = ':TSUpdate',
    cond = function()
      return not vim.g.vscode
    end
  }