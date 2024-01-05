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
      -- Filter
      "Shougo/ddc-filter-matcher_head",
      "Shougo/ddc-filter-sorter_rank",
      "Shougo/ddc-filter-converter_truncate_abbr",
      "Shougo/ddc-filter-converter_remove_overlap",
      -- Preview
      "uga-rosa/ddc-previewer-floating",
      "matsui54/denops-signature_help",
    },
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
      })

      patch_global("cmdlineSources", {
        [":"] = {
          "cmdline-history",
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
        line = {
          mark = "[LINE]",
        },
        cmdline = {
          mark = "[CMD]",
        },
        ["cmdline-history"] = {
          mark = "[HIST]",
        },
      })

      patch_global("sourceParams", {
        lsp = {
          enableResolveItem = true,
          enableAdditionalTextEdit = true,
          confirmBehavior = "replace",
        },
        line = {
          maxSize = 1000,
        },
      })

      require("ddc_previewer_floating").enable()
      vim.fn["ddc#enable"]()
    end,
  },
  {
    "Shougo/pum.vim",
    config = function()
      vim.fn["pum#set_option"]({
        auto_select = true,
        padding = true,
        border = "none",
        preview = false,
        scrollbar_char = "▋",
        highlight_normal_menu = "Normal",
      })
      -- local opts = { silent = true, noremap = true}
      local opts = { noremap = true }
      vim.keymap.set('i', '<C-n>', function() vim.fn["pum#map#select_relative"](1) end, opts)
      vim.keymap.set('i', '<Down>', function() vim.fn["pum#map#select_relative"](1) end, opts)
      vim.keymap.set('i', '<C-p>', function() vim.fn["pum#map#select_relative"](-1) end, opts)
      vim.keymap.set('i', '<Up>', function() vim.fn["pum#map#select_relative"](-1) end, opts)
      vim.keymap.set('i', '<C-y>', function() vim.fn["pum#map#confirm"]() end, opts)
      vim.keymap.set('i', '<CR>', function()
        return vim.fn["pum#visible"]() and vim.fn["pum#map#confirm"]() or '\r'
      end, { noremap = true, expr = true })
      vim.keymap.set('i', '<C-e>', function() vim.fn["pum#map#cancel"]() end, opts)
      -- vim.keymap.set('c', '<Tab>', '<cmd>call pum#map#select_relative(+1)<CR>', opts)
      -- vim.keymap.set('c', '<S-Tab>', '<cmd>call pum#map#select_relative(-1)<CR>', opts)
      -- vim.keymap.set('c', '<C-n>', '<cmd>call pum#map#select_relative(+1)<CR>', opts)
      -- vim.keymap.set('c', '<C-p>', '<cmd>call pum#map#select_relative(-1)<CR>', opts)
      -- vim.keymap.set('c', '<C-y>', '<cmd>call pum#map#confirm()<CR>', opts)
      -- vim.keymap.set('c', '<C-e>', '<cmd>call pum#map#cancel()<CR>', opts)
    end,
  },
  {
    "uga-rosa/ddc-previewer-floating",
    config = function()
      require("ddc_previewer_floating").setup({
        ui = "pum",
        border = "single",
        window_options = {
          wrap = false,
          number = false,
          signcolumn = "no",
          cursorline = false,
          foldenable = false,
        },
      })
    end,
  },
  {
    "matsui54/denops-signature_help",
    dependencies = { "vim-denops/denops.vim" },
    config = function()
      vim.g.signature_help_config = {
        contentsStyle = "currentLabel",
        viewStyle = "virtual",
      }
      vim.fn["signature_help#enable"]()
    end,
  },
}
