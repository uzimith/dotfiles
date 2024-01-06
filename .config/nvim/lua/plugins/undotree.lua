return {
  "jiaoshijie/undotree",
  dependencies = "nvim-lua/plenary.nvim",
  keys = {
    { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
  },
  config = function()
    local undotree = require('undotree')

    undotree.setup({
      float_diff = true,
      layout = "left_bottom",
      position = "left",
      ignore_filetype = { 'undotree', 'undotreeDiff' },
      window = {
        winblend = 0,
      },
    })
    vim.keymap.set('n', '<leader>u', undotree.toggle, { noremap = true, silent = true })
  end,
}
