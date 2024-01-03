return {
{
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "Shougo/ddc-source-lsp",
    },
    config = function()
    -- ポップアップウィンドウのボーダースタイルを設定
    require("lspconfig.ui.windows").default_options.border = "single"
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
    vim.diagnostic.config({ float = { border = "single" } })

    require("mason").setup()
    require("mason-lspconfig").setup()

    local lspconfig = require("lspconfig")
    local ddc_source_lsp = require("ddc_source_lsp")

    require("mason-lspconfig").setup_handlers({
        function(server)
        local buf_full_filename = vim.api.nvim_buf_get_name(0)

        local opts = {
            capabilities = ddc_source_lsp.make_client_capabilities(),
        }

        local node_root_dir = lspconfig.util.root_pattern("package.json")
        local is_node_dir = node_root_dir(buf_full_filename) ~= nil

        local deno_root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc")
        local is_deno_dir = deno_root_dir(buf_full_filename) ~= nil

        -- denols と tsserver を出し分ける
        -- ref: https://zenn.dev/kawarimidoll/articles/2b57745045b225
        if server == "denols" then
            if not is_deno_dir then
            return
            end
            opts.root_dir = deno_root_dir
            opts.cmd = { "deno", "lsp", "--unstable" }
            opts.init_options = { lint = true, unstable = true }

        -- Node.js
        elseif server == "tsserver" then
            if is_deno_dir or not is_node_dir then
            return
            end
            opts.root_dir = node_root_dir

        -- css
        elseif server == "cssls" then
            opts.filetypes = { "css", "scss", "sass", "less" }

        -- yaml
        elseif server == "yamlls" then
            opts.settings = {
            yaml = {
                keyOrdering = false,
            },
            }

        -- emmet
            elseif server == "emmet_language_server" then
            opts.filetypes = { "html", "css", "scss", "sass", "less" }

            -- 内蔵フォーマッタを無効化
        elseif server == "html" or server == "jsonls" or server == "lua_ls" then
        end

        lspconfig[server].setup(opts)
        end,
    })

    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
        local opts = { buffer = ev.buf }

        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gK', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', 'gn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', 'gc', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        end,
    })
    end,
},
{
    "williamboman/mason-lspconfig.nvim",
    opts = {
    ensure_installed = {
        "denols",
        "gopls",
        "tsserver",
        "lua_ls",
        "yamlls",
        "jsonls",
        "rust_analyzer",
        "cssls",
        "eslint",
        "emmet_language_server",
    },
    automatic_installation = true,
    },
},
{
    "williamboman/mason.nvim",
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
