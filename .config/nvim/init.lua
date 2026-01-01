require("core/option")
require("core/keymap")
require("core/lazyvim")

vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("startup", { clear = true }),
  callback = function()
    local stats = require("lazy").stats()
    vim.notify(string.format("Neovim started in %.2fms", stats.startuptime), vim.log.levels.INFO)
  end,
})
