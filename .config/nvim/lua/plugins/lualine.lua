return {
  'nvim-lualine/lualine.nvim',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  cond = function()
    return not vim.g.vscode
  end,
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'solarized',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          'NvimTree',
          'statusline',
          'winbar',
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {
        lualine_a = {
          {
            'tabs',
            tab_max_length = 40,
            max_length = vim.o.columns / 3,
            mode = 1,
            path = 0,
            symbols = {
              modified = ' ●',
              alternate_file = '#',
              directory = '',
            },
            tabs_color = {},
          },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      },
      winbar = {},
      inactive_winbar = {},
      extensions = {}
    }
  end
}
