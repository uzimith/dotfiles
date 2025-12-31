return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "Shougo/ddc-source-lsp",
      "nvimtools/none-ls.nvim",
      "artemave/workspace-diagnostics.nvim",
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
        float = { border = "single" },
        loclist = {
          open = true,
        },
      })

      -- lua_ls の設定
      vim.lsp.config.lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }
            }
          }
        }
      }

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }

          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', 'gk', function() vim.lsp.buf.hover({ border = "single" }) end, opts)
          vim.keymap.set('n', 'ge', vim.diagnostic.open_float, opts)

          vim.keymap.set('n', 'gh', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', 'gn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', 'gf', function() vim.lsp.buf.format { async = true } end)

          vim.keymap.set("n", "gq", function()
            vim.diagnostic.setqflist({ open = false })
            vim.diagnostic.setloclist({ open = false })
          end, opts)
          vim.keymap.set("n", "gQ", function()
            for _, client in ipairs(vim.lsp.get_clients({ bufnr = ev.buf })) do
              require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
            end
          end, opts)

          vim.keymap.set("n", "gr", "<Cmd>Ddu -name=lsp lsp_references<CR>", opts)

          vim.keymap.set('', ']d', function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
          vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)

          vim.api.nvim_create_autocmd("DiagnosticChanged", {
            callback = function()
              vim.diagnostic.setqflist({ open = false })
              vim.diagnostic.setloclist({ open = false })
            end,
          })

          vim.api.nvim_create_autocmd("BufEnter", {
            callback = function()
              vim.diagnostic.setloclist({ open = false })
            end,
          })
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
