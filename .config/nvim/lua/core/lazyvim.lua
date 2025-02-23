local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "git@github.com:folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local lazyOpts = {
  defaults = {
    lazy = false,
  },
  performance = {
    cache = {
      enabled = true,
    },
  },
  change_detection = {
    notify = false,
  },
}

require('lazy').setup('plugins', lazyOpts)
