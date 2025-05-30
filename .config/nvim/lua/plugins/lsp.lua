return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "Shougo/ddc-source-lsp",
      "jay-babu/mason-null-ls.nvim",
      "nvimtools/none-ls.nvim",
    },
    cond = function()
      return not vim.g.vscode
    end,
    config = function()
      -- diagnostic
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
          end,
        },
      })

      -- ポップアップウィンドウのボーダースタイルを設定
      require("lspconfig.ui.windows").default_options.border = "single"
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
      vim.diagnostic.config({ float = { border = "single" } })

      local lspconfig = require("lspconfig")
      local ddc_source_lsp = require("ddc_source_lsp")

      local common_on_attach = function(client, bufnr)
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ async = false, bufnr = bufnr, })
            end,
          })
        end
      end

      local enable_fmt_on_attach = function(client, bufnr)
        common_on_attach(client, bufnr)
        client.server_capabilities.documentFormattingProvider = true
      end

      local disable_fmt_on_attach = function(client, bufnr)
        common_on_attach(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
      end

      require("null-ls").setup({
        on_attach = enable_fmt_on_attach
      })

      -- BUG: attempt to call field 'setup_handlers' (a nil value)
      -- require("mason-lspconfig").setup_handlers({
      --   function(server)
      --     local opts = {
      --       capabilities = ddc_source_lsp.make_client_capabilities(),
      --       on_attach = enable_fmt_on_attach,
      --     }
      --
      --
      --     -- Node.js
      --     if server == "tsserver" then
      --       opts.on_attach = disable_fmt_on_attach
      --
      --       local function organize_imports()
      --         local params = {
      --           command = "_typescript.organizeImports",
      --           arguments = { vim.api.nvim_buf_get_name(0) },
      --           title = ""
      --         }
      --         vim.lsp.buf.execute_command(params)
      --       end
      --
      --       local function rename_file()
      --         local source_file, target_file
      --
      --         vim.ui.input({
      --             prompt = "Source : ",
      --             completion = "file",
      --             default = vim.api.nvim_buf_get_name(0)
      --           },
      --           function(input)
      --             source_file = input
      --           end
      --         )
      --         vim.ui.input({
      --             prompt = "Target : ",
      --             completion = "file",
      --             default = source_file
      --           },
      --           function(input)
      --             target_file = input
      --           end
      --         )
      --
      --         local params = {
      --           command = "_typescript.applyRenameFile",
      --           arguments = {
      --             {
      --               sourceUri = source_file,
      --               targetUri = target_file,
      --             },
      --           },
      --           title = ""
      --         }
      --
      --         vim.lsp.util.rename(source_file, target_file)
      --         vim.lsp.buf.execute_command(params)
      --       end
      --
      --
      --       opts.commands = {
      --         OrganizeImports = {
      --           organize_imports,
      --           description = "Organize Imports"
      --         },
      --         RenameFile = {
      --           rename_file,
      --           description = "Rename File"
      --         },
      --       }
      --
      --       -- css
      --     elseif server == "cssls" then
      --       opts.filetypes = { "css", "scss", "sass", "less" }
      --
      --       -- yaml
      --     elseif server == "yamlls" then
      --       opts.settings = {
      --         yaml = {
      --           keyOrdering = false,
      --         },
      --       }
      --
      --       -- emmet
      --     elseif server == "emmet_language_server" then
      --       opts.filetypes = { "html", "css", "scss", "sass", "less" }
      --     end
      --
      --     lspconfig[server].setup(opts)
      --   end,
      -- })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }

          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          -- vim.keymap.set("n", "gd", "<Cmd>Ddu lsp_definition<CR>", opts)
          vim.keymap.set('n', 'gk', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', 'gn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', 'gc', vim.lsp.buf.code_action, opts)
          -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set("n", "gq", "<Cmd>Ddu -name=lsp lsp_diagnostic<CR>", opts)
          vim.keymap.set("n", "gr", "<Cmd>Ddu -name=lsp lsp_references<CR>", opts)
          vim.keymap.set('n', ']g', '<CMD>lua vim.diagnostic.goto_next()<CR>', opts)
          vim.keymap.set('n', '[g', '<CMD>lua vim.diagnostic.goto_prev()<CR>', opts)
          vim.keymap.set('n', 'ge', vim.diagnostic.open_float, opts)
          vim.keymap.set('n', 'gf', function() vim.lsp.buf.format { async = true } end)
        end,
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    cond = function()
      return not vim.g.vscode
    end,
    opts = {
      ensure_installed = {
        "astro",
        "efm",
        "gopls",
        "ts_ls",
        "eslint",
        -- "denols",
        "lua_ls",
        "yamlls",
        "jsonls",
        "rust_analyzer",
        "cssls",
        "emmet_language_server",
      },
      automatic_installation = true,
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    cond = function()
      return not vim.g.vscode
    end,
    config = function()
      require('mason-null-ls').setup({
        ensure_installed = { 'prettierd', 'black', 'goimports' },
        handlers = {},
      })

      local status, null_ls = pcall(require, 'null-ls')
      if (not status) then return end

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettierd,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.goimports,
        },
        diagnostics_format = "#{m} (#{s}: #{c})",
        debug = true,
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    cond = function()
      return not vim.g.vscode
    end,
    opts = {
      ui = {
        border = "single",
        icons = {
          package_installed = " ",
          package_pending = "↻ ",
          package_uninstalled = " ",
        },
      },
    },
  },
}
