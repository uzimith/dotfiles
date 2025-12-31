return {
  "kana/vim-submode",
  lazy = false,
  config = function()
    vim.fn["submode#enter_with"]("winsize", "n", ".", "<C-w>.", "<C-w><")
    vim.fn["submode#enter_with"]("winsize", "n", ",", "<C-w>,", "<C-w>>")
    vim.fn["submode#map"]("winsize", "n", "", ".", "<C-w><")
    vim.fn["submode#map"]("winsize", "n", "", ",", "<C-w>>")
  end,
}
