return {
  {
    "Shougo/ddc.vim",
    lazy = false,
    dependencies = {
      "vim-denops/denops.vim",
      -- UI
      "Shougo/pum.vim",
      "Shougo/ddc-ui-pum",
      -- Source
      "Shougo/ddc-source-around",
      "Shougo/ddc-source-lsp",
      "Shougo/ddc-source-cmdline",
      "Shougo/ddc-source-cmdline-history",
      "LumaKernel/ddc-source-file",
      "Shougo/ddc-source-line",
      "octaltree/cmp-look",
      -- Filter
      "Shougo/ddc-filter-matcher_head",
      "Shougo/ddc-filter-sorter_rank",
      "Shougo/ddc-filter-converter_truncate_abbr",
      "Shougo/ddc-filter-converter_remove_overlap",
      -- Preview
      "matsui54/denops-signature_help",
    },
    cond = function()
      return not vim.g.vscode
    end,
    config = function()
      local patch_global = vim.fn["ddc#custom#patch_global"]

      patch_global("ui", "pum")


      patch_global("autoCompleteEvents", {
        "InsertEnter",
        "TextChangedI",
        "TextChangedP",
        "CmdlineChanged",
      })

      patch_global("sources", {
        "lsp",
        "file",
        "around",
        "look",
      })

      patch_global("cmdlineSources", {
        [":"] = {
          "cmdline_history",
          "cmdline",
          "around",
        },
        ["/"] = {
          "around",
          "line",
        },
        ["?"] = {
          "around",
        },
      })

      patch_global("sourceOptions", {
        _ = {
          matchers = { "matcher_head" },
          sorters = { "sorter_rank" },
          converters = { "converter_truncate_abbr", "converter_remove_overlap" },
          ignoreCase = true,
          minAutoCompleteLength = 1,
        },
        around = {
          mark = "[A]",
        },
        lsp = {
          mark = "[LSP]",
          dup = "keep",
          keywordPattern = "[a-zA-Z0-9_À-ÿ$#\\-*]*",
          forceCompletionPattern = [[\.\w*|:\w*|->\w*]],
          sorters = { "sorter_lsp-kind", "sorter_rank" },
        },
        file = {
          mark = "[FILE]",
          isVolatile = true,
          forceCompletionPattern = [[\S/\S*]],
        },
        look = {
          converters = { "loud", "matcher_head" },
          matchers = {},
          mark = "[LOOK]",
          isVolatile = true,
        },
        line = {
          mark = "[LINE]",
        },
        cmdline = {
          mark = "[CMD]",
        },
        ["cmdline_history"] = {
          mark = "[HIST]",
        },
      })

      patch_global("sourceParams", {
        lsp = {
          enableResolveItem = true,
          enableAdditionalTextEdit = true,
          confirmBehavior = "replace",
        },
        look = {
          convertCase = true,
          dict = nil,
        },
        line = {
          maxSize = 1000,
        },
      })

      vim.keymap.set('n', ':', '<Cmd>call ddc#enable_cmdline_completion()<CR>:', { noremap = true })
      vim.keymap.set('i', ':', '<Cmd>call ddc#enable_cmdline_completion()<CR>:', { noremap = true })
      vim.keymap.set('x', ':', '<Cmd>call ddc#enable_cmdline_completion()<CR>:', { noremap = true })
      vim.keymap.set('n', '/', '<Cmd>call ddc#enable_cmdline_completion()<CR>/', { noremap = true })
      vim.keymap.set('i', '/', '<Cmd>call ddc#enable_cmdline_completion()<CR>/', { noremap = true })
      vim.keymap.set('x', '/', '<Cmd>call ddc#enable_cmdline_completion()<CR>/', { noremap = true })
      vim.keymap.set('n', '?', '<Cmd>call ddc#enable_cmdline_completion()<CR>?', { noremap = true })
      vim.keymap.set('i', '?', '<Cmd>call ddc#enable_cmdline_completion()<CR>?', { noremap = true })
      vim.keymap.set('x', '?', '<Cmd>call ddc#enable_cmdline_completion()<CR>?', { noremap = true })

      vim.fn["ddc#enable"]()
    end,
  },
  {
    "Shougo/pum.vim",
    cond = function()
      return not vim.g.vscode
    end,
    config = function()
      vim.fn["pum#set_option"]({
      auto_select = true,
      padding = true,
      border = "none",
      preview = false,
      scrollbar_char = "▋",
      highlight_normal_menu = "Normal",
      })
      local opts = { noremap = true }
      vim.keymap.set('i', '<C-n>', function() vim.fn["pum#map#select_relative"](1) end, opts)
      vim.keymap.set('i', '<Down>', function() vim.fn["pum#map#select_relative"](1) end, opts)
      vim.keymap.set('i', '<C-p>', function() vim.fn["pum#map#select_relative"](-1) end, opts)
      vim.keymap.set('i', '<Up>', function() vim.fn["pum#map#select_relative"](-1) end, opts)
      vim.keymap.set('i', '<C-y>', function() vim.fn["pum#map#confirm"]() end, opts)
      vim.keymap.set('i', '<CR>', function()
      if vim.fn["pum#visible"]() then
        return '<C-y>'
      else
        return '<CR>'
      end
      end, { remap = true, expr = true })
      vim.keymap.set('i', '<C-e>', function() vim.fn["pum#map#cancel"]() end, opts)

      vim.keymap.set('c', '<Tab>', '<cmd>call pum#map#select_relative(+1)<CR>', opts)
      vim.keymap.set('c', '<S-Tab>', '<cmd>call pum#map#select_relative(-1)<CR>', opts)
      vim.keymap.set('c', '<C-n>', '<cmd>call pum#map#select_relative(+1)<CR>', opts)
      vim.keymap.set('c', '<C-p>', '<cmd>call pum#map#select_relative(-1)<CR>', opts)
      vim.keymap.set('c', '<Down>', '<cmd>call pum#map#select_relative(+1)<CR>', opts)
      vim.keymap.set('c', '<Up>', '<cmd>call pum#map#select_relative(-1)<CR>', opts)
      vim.keymap.set('c', '<C-y>', '<cmd>call pum#map#confirm()<CR>', opts)
      vim.keymap.set('c', '<C-e>', '<cmd>call pum#map#cancel()<CR>', opts)
      vim.keymap.set('c', '<CR>', function()
      if vim.fn["pum#visible"]() then
        return '<C-y><CR>'
      else
        return '<CR>'
      end
      end, { remap = true, expr = true })
    end,
  },
  {
    "matsui54/denops-signature_help",
    dependencies = { "vim-denops/denops.vim" },
    cond = function()
      return not vim.g.vscode
    end,
    config = function()
      vim.g.signature_help_config = {
        contentsStyle = "currentLabel",
        viewStyle = "virtual",
      }
      vim.fn["signature_help#enable"]()
    end,
  },
}
