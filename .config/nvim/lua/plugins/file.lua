return {
  {
    "lambdalisue/vim-file-protocol",
    lazy = false,
  },
  {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = function()
      require("oil").setup()

      local opts = { silent = true, noremap = true }
      vim.keymap.set("n", "<Leader>fi", "<Cmd>Oil<CR>", opts)
    end,
  }
}
