return {
  {
    'Bekaboo/dropbar.nvim',
    config = function()
      require('dropbar').setup({
        menu = {
          win_configs = {
            border = 'single',
          },
          -- メニューが閉じる条件を制限
          quick_navigation = false,
        },
      })
      local dropbar_api = require('dropbar.api')
      vim.keymap.set('n', ';;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
      vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
      vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
    end
  }
}
