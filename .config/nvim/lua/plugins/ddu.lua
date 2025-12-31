return {
  {
    "Shougo/ddu.vim",
    lazy = false,
    dependencies = {
      "vim-denops/denops.vim",
      -- UI
      "Shougo/ddu-ui-filer",
      "Shougo/ddu-ui-ff",
      -- Source
      "Shougo/ddu-source-action",
      "Shougo/ddu-source-file",
      "Shougo/ddu-source-file_old",
      "Shougo/ddu-source-line",
      "matsui54/ddu-source-file_external",
      "shun/ddu-source-rg",
      "shun/ddu-source-buffer",
      "matsui54/ddu-source-help",
      "uga-rosa/ddu-source-lsp",
      "kyoh86/ddu-source-quickfix_history",
      "matsui54/ddu-source-command_history",
      -- Filter
      "Shougo/ddu-filter-sorter_alpha",
      "Shougo/ddu-filter-matcher_substring",
      "Shougo/ddu-filter-matcher_relative",
      "Shougo/ddu-filter-matcher_hidden",
      -- Kind
      "Shougo/ddu-kind-file",
      "Shougo/ddu-kind-word",
      -- Column
      "ryota2357/ddu-column-icon_filename",
      -- ui-select
      "matsui54/ddu-vim-ui-select",
      -- Command
      "Shougo/ddu-commands.vim",
    },
    cond = function()
      return not vim.g.vscode
    end,
    init = function()
      local opts = { silent = true, noremap = true }
      vim.keymap.set('n', 'ss', function()
        vim.fn["ddu#start"]({ resume = true })
      end, opts)
      vim.keymap.set("n", "sr", "<Cmd>Ddu ghq<CR>", opts)
      vim.keymap.set("n", "sd", function()
        vim.fn["ddu#start"]({
          sources = {
            { name = "file" },
          },
          sourceOptions = {
            file = {
              path = vim.fn.expand('%:p:h'),
            },
          },
        })
      end, opts)
      vim.keymap.set("n", "sf", function()
        vim.fn["ddu#start"]({
          sources = {
            { name = "file_external" },
          },
          sourceOptions = {
            file_external = {
              path = vim.fn.expand('%:p:h'),
            },
          },
        })
      end, opts)
      vim.keymap.set("n", "sF", function()
        vim.fn["ddu#start"]({
          sources = {
            { name = "file_external" },
          },
        })
      end, opts)
      vim.keymap.set("n", "sb", "<Cmd>Ddu buffer<CR>", opts)
      vim.keymap.set("n", "sm", "<Cmd>Ddu file_old<CR>", opts)
      vim.keymap.set("n", "sq", "<Cmd>Ddu quickfix_history<CR>", opts)
      vim.keymap.set("n", "sl", '<Cmd>Ddu line<CR>', opts)
      vim.keymap.set("n", "sg", function()
        vim.fn["ddu#start"]({
          name = 'grep',
          input = '',
        })
      end, opts)
      vim.keymap.set('n', 's*', function() vim.fn["ddu#start"]({ name = 'grep', input = vim.fn.expand('<cword>') }) end,
        opts)
      vim.keymap.set('x', 's*', function()
        vim.cmd.normal({ '"vy', bang = true, mods = { noautocmd = true } })
        local text = vim.fn.getreg('v')
        vim.fn["ddu#start"]({ name = 'grep', input = text })
      end, opts)

      vim.keymap.set("n", "sr", "<Cmd>Ddu -name=lsp lsp_references<CR>", opts)
      vim.keymap.set("n", "sw", '<Cmd>Ddu lsp_workspaceSymbol<CR>', opts)
      vim.keymap.set("n", "gc", '<Cmd>Ddu lsp_codeAction<CR>', opts)

      vim.keymap.set("n", "<Leader>fi", [[<Cmd>Ddu -name=filer -searchPath=`expand('%:p')`<CR>]], opts)

      vim.keymap.set("c", "<C-h>", "<C-u><ESC><Cmd>Ddu -name=command_history command_history<CR>", opts)
      vim.keymap.set('c', '<C-j>', '<cmd>call pum#map#insert_relative(+1)<CR>', opts)
      vim.keymap.set('c', '<C-k>', '<cmd>call pum#map#insert_relative(-1)<CR>', opts)
    end,
    config = function()
      local reset_ui = function()
        local top = 4
        local width = vim.opt.columns:get()
        local height = vim.opt.lines:get()
        local win_width = math.floor(width * 0.9)
        local win_height = math.floor(height * 0.9)

        vim.fn["ddu#custom#patch_global"]({
          ui = "ff",
          uiParams = {
            _ = {
            },
            ff = {
              prompt = '> ',
              winWidth = win_width,
              winHeight = win_height,
              winCol = math.floor((width - win_width) / 2),
              winRow = top,
              split = "floating",
              floatingBorder = "single",
              preview = true,
              previewFloating = true,
              previewFloatingBorder = "single",
              previewSplit = "vertical",
              previewWidth = math.floor(win_width * 0.3),
              previewHeight = win_height,
              previewCol = math.floor((width - win_width) / 2) + math.floor(win_width * 0.7) + 1,
              previewRow = top,
              startAutoAction = true,
              autoAction = {
                name = "preview",
              },
            },
            filer = {
              winWidth = 30,
              split = "vertical",
              splitDirection = "topleft",
              previewSplit = "no",
            },
          },
        })
      end

      reset_ui()

      -- 幅を再計算するために画面がリサイズされたら再設定する
      vim.api.nvim_create_autocmd("VimResized", {
        pattern = "*",
        callback = reset_ui,
      })

      vim.fn["ddu#custom#alias"]('_', 'source', 'ghq', 'file_external')
      vim.fn["ddu#custom#patch_global"]({
        sourceParams = {
          file_external = {
            cmd = { "fd", ".", "-H", "-E", ".git", "-t", "f" },
          },
          ghq = {
            cmd = { 'ghq', 'list', '-p' },
          },
          rg = {
            inputType = "regex",
            args = { "--json", "--column", "--no-heading", "--color", "never", "--hidden", "--glob", "!.git" },
          },
        },
        sourceOptions = {
          _ = {
            ignoreCase = true,
            matchers = { "matcher_substring" },
          },
          file = {
            sorters = { "sorter_alpha" },
            columns = { "icon_filename", "file_git_status", "file_buf_modified" }
          },
          file_external = {
            sorters = { "sorter_alpha" },
            columns = { "icon_filename", "file_git_status", "file_buf_modified" }
          },
          file_old = {
            matchers = { "matcher_substring", "matcher_relative" },
          },
          lsp_documentSymbol = {
            converters = { "converter_lsp_symbol" },
          },
          lsp_workspaceSymbol = {
            converters = { "converter_lsp_symbol" },
          },
          lsp_diagnostic = {
            converters = { "converter_lsp_diagnostic" },
          },
        },
        filterParams = {
          matcher_substring = {
            highlightMatched = "Search",
          },
        },
        kindOptions = {
          file = {
            defaultAction = "open",
          },
          file_open = {
            defaultAction = "open",
          },
          lsp = {
            defaultAction = "open",
          },
          help = {
            defaultAction = "open",
          },
          action = {
            defaultAction = "do",
          },
          word = {
            defaultAction = "append",
          },
          ui_select = {
            defaultAction = "select",
          },
          lsp_codeAction = {
            defaultAction = "apply",
          },
          quickfix_history = {
            defaultAction = "open",
          },
          command_history = {
            defaultAction = "edit",
          },
        },
      })

      -- Live grep
      vim.fn["ddu#custom#patch_local"]("grep", {
        sources = {
          { name = "rg" },
        },
        sourceOptions = {
          rg = {
            matchers = {},
            volatile = true,
          },
        },
      })

      -- Filer
      vim.fn["ddu#custom#patch_local"]("filer", {
        ui = "filer",
        sync = true,
        sources = {
          { name = "file" },
        },
        sourceOptions = {
          _ = {
            sorters = { "sorter_alpha" },
            columns = { "icon_filename" },
            matchers = {},
          },
        },
        actionParams = {
          open = {
            command = 'edit',
          },
        },
      })


      -- keymaps
      local opts = { buffer = true, silent = true, noremap = true }
      local nowait = { buffer = true, silent = true, noremap = true, nowait = true }

      local common_keymaps = function()
        vim.wo.cursorline = true
        vim.keymap.set("n", "<CR>", function()
          local item = vim.fn["ddu#ui#get_item"]()
          if item.isTree then
            vim.fn["ddu#ui#do_action"]("itemAction", { name = "narrow" })
          else
            vim.fn["ddu#ui#do_action"]("itemAction")
          end
        end, opts)
        vim.keymap.set("n", "<SPACE><SPACE>", '<Cmd>call ddu#ui#do_action("toggleSelectItem")<CR>', opts)
        vim.keymap.set("n", "<ESC>", '<Cmd>call ddu#ui#do_action("quit")<CR>', nowait)
        vim.keymap.set("n", "q", '<Cmd>call ddu#ui#do_action("quit")<CR>', nowait)
        vim.keymap.set("n", "a", '<Cmd>call ddu#ui#do_action("chooseAction")<CR>', opts)
        vim.keymap.set("n", "<C-h>",
          function() vim.fn["ddu#ui#do_action"]("itemAction", { name = "narrow", params = { path = ".." } }) end,
          opts)

        -- ファイル操作
        vim.keymap.set("n", "y", '<Cmd>call ddu#ui#do_action("itemAction", {"name": "copy"})<CR>', opts)
        vim.keymap.set("n", "p", '<Cmd>call ddu#ui#do_action("itemAction", {"name": "paste"})<CR>', opts)
        vim.keymap.set("n", "d", '<Cmd>call ddu#ui#do_action("itemAction", {"name": "delete"})<CR>', opts)
        vim.keymap.set("n", "r", '<Cmd>call ddu#ui#do_action("itemAction", {"name": "rename"})<CR>', opts)
        vim.keymap.set("n", "m", '<Cmd>call ddu#ui#do_action("itemAction", {"name": "move"})<CR>', opts)
        vim.keymap.set("n", "N", '<Cmd>call ddu#ui#do_action("itemAction", {"name": "newFile"})<CR>', opts)
        vim.keymap.set("n", "K", '<Cmd>call ddu#ui#do_action("itemAction", {"name": "newDirectory"})<CR>', opts)
        vim.keymap.set("n", "x", '<Cmd>call ddu#ui#do_action("itemAction", {"name": "executeSystem"})<CR>', opts)

        -- toggle hidden files
        vim.keymap.set("n", ">", function()
          local show_hidden = vim.b.ddu_filer_show_hidden or false
          vim.b.ddu_filer_show_hidden = not show_hidden
          local matchers = show_hidden and { "matcher_hidden" } or {}
          vim.fn["ddu#ui#do_action"]('updateOptions', {
            sourceOptions = {
              _ = {
                matchers = matchers,
              },
            },
          })
          vim.fn['ddu#ui#do_action']('redraw', { method = 'refreshItems' })
        end, opts)
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "ddu-ff",
        callback = function()
          common_keymaps()

          -- フィルターを開く
          vim.keymap.set("n", "i", '<Cmd>call ddu#ui#do_action("openFilterWindow")<CR>', opts)
          -- -- プレビュー
          vim.keymap.set("n", "K", '<Cmd>call ddu#ui#do_action("togglePreview")<CR>', opts)
          -- -- 一括でQuickfixに流しこむ
          vim.keymap.set("n", "<C-q>", function()
            vim.fn["ddu#ui#multi_actions"]({
              { "clearSelectAllItems" },
              { "toggleAllItems" },
              { "itemAction",         { name = "quickfix" } },
            })
          end, opts)
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "ddu-filer",
        callback = function()
          common_keymaps()

          vim.keymap.set('n', 'o', function() vim.fn["ddu#ui#do_action"]('expandItem', { mode = 'toggle' }) end, opts)
          vim.keymap.set('n', 'e', function() vim.fn["ddu#ui#do_action"]('itemAction', { name = 'open' }) end, opts)
          vim.keymap.set("n", "q", function() vim.fn["ddu#ui#do_action"]("quit") end, nowait)
          vim.keymap.set("n", "<ESC>", function() vim.fn["ddu#ui#do_action"]("quit") end, nowait)
        end,
      })
    end,
  },
}
