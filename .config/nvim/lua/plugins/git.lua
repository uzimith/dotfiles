return {
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    cond = function()
      return not vim.g.vscode
    end,
    config = function()
      require('gitsigns').setup {
        signs                        = {
          add          = { text = '┃' },
          change       = { text = '┃' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        signs_staged                 = {
          add          = { text = '┃' },
          change       = { text = '┃' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        signs_staged_enable          = true,
        signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
        numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir                 = {
          follow_files = true
        },
        auto_attach                  = true,
        attach_to_untracked          = false,
        current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts      = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
          virt_text_priority = 100,
          use_focus = true,
        },
        current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
        sign_priority                = 6,
        update_debounce              = 100,
        status_formatter             = nil,   -- Use default
        max_file_length              = 40000, -- Disable if file is longer than this (in lines)
        preview_config               = {
          -- Options passed to nvim_open_win
          border = 'single',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        },
        on_attach                    = function(bufnr)
          local gitsigns = require('gitsigns')

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']g', function()
            if vim.wo.diff then
              vim.cmd.normal({ ']g', bang = true })
            else
              gitsigns.nav_hunk('next')
            end
          end)

          map('n', '[g', function()
            if vim.wo.diff then
              vim.cmd.normal({ '[g', bang = true })
            else
              gitsigns.nav_hunk('prev')
            end
          end)

          map('n', '<leader>gs', gitsigns.stage_hunk)
          map('n', '<leader>gr', gitsigns.reset_hunk)

          map('v', '<leader>gs', function()
            gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end)

          map('v', '<leader>gr', function()
            gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end)

          map('n', '<leader>gp', gitsigns.preview_hunk_inline)

          map('n', '<leader>gb', gitsigns.blame)
          map('n', '<leader>gi', gitsigns.blame_line)
          map('n', '<leader>gI', function()
            gitsigns.blame_line({ full = true })
          end)

          map('n', '<leader>gd', gitsigns.diffthis)

          map('n', '<leader>gD', function()
            gitsigns.diffthis('~')
          end)

          map('n', '<leader>gq', function()
            gitsigns.setqflist('all', { open = false })
            gitsigns.setqflist('attached', { open = false, use_location_list = true })
          end)

          -- Text object
          map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
        end
      }
    end,
  },
  {
    "tpope/vim-fugitive",
    cond = function()
      return not vim.g.vscode
    end,
    lazy = false,
    config = function()
      local function map(mode, l, r, opts)
        opts = opts or {}
        vim.keymap.set(mode, l, r, opts)
      end
      map('n', '<leader>go', ':<C-U>GBrowse<CR>')
    end,
  },
  {
    "tpope/vim-rhubarb",
    cond = function()
      return not vim.g.vscode
    end,
    lazy = false,
  },
}
