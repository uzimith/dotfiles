return {
  "monaqa/dps-dial.vim",
  dependancies = {
    "vim-denops/denops.vim",
  },
  cond = function()
    return not vim.g.vscode
  end,
  lazy = false,
  config = function()
    vim.g["dps_dial#augends"] = {
      'decimal',
      'date-slash',
      { kind = 'constant', opts = { elements = { 'true', 'false' }, cyclic = true, word = false } },
      { kind = 'case',     opts = { cases = { 'camelCase', 'snake_case' }, cyclic = true } },
    }

    local opts = {}
    vim.keymap.set('n', '<C-a>', '<Plug>(dps-dial-increment)', opts)
    vim.keymap.set('n', '<C-x>', '<Plug>(dps-dial-decrement)', opts)
  end,
}
