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
    init = function()
      local opts = { silent = true, noremap = true }
      vim.keymap.set("n", "sr", "<Cmd>Ddu ghq<CR>", opts)
      vim.keymap.set("n", "sf", "<Cmd>Ddu file_external<CR>", opts)
      vim.keymap.set("n", "sb", "<Cmd>Ddu buffer<CR>", opts)
      vim.keymap.set("n", "sm", "<Cmd>Ddu file_old<CR>", opts)
      vim.keymap.set("n", "sq", "<Cmd>Ddu quickfix_history<CR>", opts)
      vim.keymap.set('n', 'sg', function() vim.fn["ddu#start"]({ name = 'grep', input = vim.fn.expand('<cword>') }) end,
        opts)
      vim.keymap.set("n", "sG", '<Cmd>Ddu -name=grep<CR>', opts)
      vim.keymap.set("c", "<C-h>", [[<C-u><ESC><Cmd>Ddu command_history<CR>]], opts)
      vim.keymap.set("n", "<Leader>fi", [[<Cmd>Ddu -name=filer -searchPath=`expand('%:p')`<CR>]], opts)
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
              previewWidth = math.floor(win_width * 0.5),
              previewHeight = win_height - 2,
              previewCol = math.floor(width / 2) - 2,
              previewRow = top + 1,
              startFilter = true,
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

      vim.fn["ddu#custom#alias"]('source', 'ghq', 'file_external')
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
          file_old = {
            matchers = { "matcher_substring", "matcher_relative" },
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
            matchers = { "matcher_hidden" },
          },
        },
        actionParams = {
          open = {
            command = 'edit',
          },
        },
      })

      -- LSP
      vim.fn["ddu#custom#patch_local"]("lsp", {
        uiParams = {
          ff = {
            startFilter = false,
          },
        },
      })

      -- keymaps
      local opts = { buffer = true, silent = true, noremap = true }
      local nowait = { buffer = true, silent = true, noremap = true, nowait = true }

      local common_keymaps = function()
        vim.wo.cursorline = true
        vim.keymap.set("n", "<CR>", '<Cmd>call ddu#ui#do_action("itemAction")<CR>', opts)
        vim.keymap.set("n", "os",
          '<Cmd>call ddu#ui#do_action("itemAction", {"name": "open", "params": {"command": "split"}})<CR>', opts)
        vim.keymap.set("n", "ov",
          '<Cmd>call ddu#ui#do_action("itemAction", {"name": "open", "params": {"command": "vsplit"}})<CR>', opts)
        vim.keymap.set("n", "<SPACE>", '<Cmd>call ddu#ui#do_action("toggleSelectItem")<CR>', opts)
        vim.keymap.set("n", "<ESC>", '<Cmd>call ddu#ui#do_action("quit")<CR>', nowait)
        vim.keymap.set("n", "q", '<Cmd>call ddu#ui#do_action("quit")<CR>', nowait)
        vim.keymap.set("n", "a", '<Cmd>call ddu#ui#do_action("chooseAction")<CR>', opts)
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "ddu-filer",
        callback = function()
          -- ファイル操作
          vim.keymap.set("n", "y", '<Cmd>call ddu#ui#do_action("itemAction", {"name": "copy"})<CR>', opts)
          vim.keymap.set("n", "p", '<Cmd>call ddu#ui#do_action("itemAction", {"name": "paste"})<CR>', opts)
          vim.keymap.set("n", "d", '<Cmd>call ddu#ui#do_action("itemAction", {"name": "delete"})<CR>', opts)
          vim.keymap.set("n", "r", '<Cmd>call ddu#ui#do_action("itemAction", {"name": "rename"})<CR>', opts)
          vim.keymap.set("n", "m", '<Cmd>call ddu#ui#do_action("itemAction", {"name": "move"})<CR>', opts)
          vim.keymap.set("n", "n", '<Cmd>call ddu#ui#do_action("itemAction", {"name": "newFile"})<CR>', opts)
          vim.keymap.set("n", "N", '<Cmd>call ddu#ui#do_action("itemAction", {"name": "newDirectory"})<CR>', opts)
          vim.keymap.set("n", "x", '<Cmd>call ddu#ui#do_action("itemAction", {"name": "executeSystem"})<CR>', opts)
          -- -- ディレクトリなら展開、ファイルなら開く
          vim.cmd([[nnoremap <buffer><expr> <CR>
             \ ddu#ui#get_item()->get('isTree', v:false)
             \ ? "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'narrow'})<CR>"
             \ : "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'open'})<CR>"]])
          vim.cmd([[nnoremap <buffer><expr> o "<Cmd>call ddu#ui#do_action('expandItem', {'mode': 'toggle'})<CR>"]])
          vim.keymap.set('n', 'o', function() vim.fn["ddu#ui#filer#do_action"]('expandItem', { mode = 'toggle' }) end,
            opts)
          vim.keymap.set('n', 'e', function() vim.fn["ddu#ui#filer#do_action"]('itemAction', { name = 'open' }) end, opts)
          vim.keymap.set('n', 'h',
            function() vim.fn["ddu#ui#filer#do_action"]('itemAction', { name = 'narrow', params = { path = '..' } }) end,
            opts)
          vim.keymap.set("n", "K", '<Cmd>call ddu#ui#do_action("togglePreview")<CR>', opts)
          vim.keymap.set("n", "q", '<Cmd>call ddu#ui#do_action("quit")<CR>', nowait)
          vim.keymap.set("n", "<ESC>", '<Cmd>call ddu#ui#do_action("quit")<CR>', nowait)


          -- toggle hidden files
          local function toggle(array, needle)
            local idx = -1
            for k, v in ipairs(array) do
              if v == needle then idx = k end
            end
            if idx ~= -1 then
              table.remove(array, idx)
            else
              table.insert(array, needle)
            end
            return array
          end

          local function toggleHidden()
            local cur = vim.fn['ddu#custom#get_current'](vim.b.ddu_ui_name)
            local source_opts = cur['sourceOptions'] or {}
            local opts_all = source_opts['_'] or {}
            local matchers = opts_all['matchers'] or {}
            return toggle(matchers, 'matcher_hidden')
          end

          vim.keymap.set("n", ">", function()
            vim.fn["ddu#ui#filer#do_action"]('updateOptions', {
              sourceOptions = {
                _ = {
                  matchers = toggleHidden(),
                },
              },
            })
            vim.fn['ddu#ui#do_action']('checkItems')
          end, { buffer = true, noremap = true })
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "ddu-ff",
        callback = function()
          common_keymaps()
          -- -- フィルターを開く
          vim.keymap.set("n", "i", '<Cmd>call ddu#ui#do_action("openFilterWindow")<CR>', opts)
          -- -- プレビュー
          vim.keymap.set("n", "K", '<Cmd>call ddu#ui#do_action("togglePreview")<CR>', opts)
          -- -- 一括でQuickfixに流しこむ
          vim.keymap.set("n", "<C-q>", function()
            vim.fn["ddu#ui#ff#multi_actions"]({
              { "clearSelectAllItems" },
              { "toggleAllItems" },
              { "itemAction",         { name = "quickfix" } },
            })
          end, opts)
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "ddu-ff-filter",
        callback = function()
          vim.keymap.set("n", "q", "<Cmd>close<CR>", nowait)
          vim.keymap.set("n", "<ESC>", "<Cmd>close<CR>", nowait)
          vim.keymap.set("i", "<CR>", '<Cmd>call ddu#ui#do_action("itemAction")<CR>', opts)
          vim.keymap.set("i", "jj", "<Cmd>close<CR><Cmd>stopinsert<CR>", opts)
          -- -- 一括でQuickfixに流しこむ
          vim.keymap.set("i", "<C-q>", function()
            vim.fn["ddu#ui#ff#multi_actions"]({
              { "clearSelectAllItems" },
              { "toggleAllItems" },
              { "itemAction",         { name = "quickfix" } },
            })
          end, opts)
        end,
      })
    end,
  },
}
