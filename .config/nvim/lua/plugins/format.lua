local function biome_or_prettier()
  local has_biome = vim.fs.find({ "biome.json", "biome.jsonc" }, {
    upward = true,
    path = vim.api.nvim_buf_get_name(0),
  })[1]
  return has_biome and { "biome-check" } or { "prettier" }
end

local formatters_by_ft = {
  lua = { "stylua" },
  sql = { "sql_formatter" },
  css = biome_or_prettier,
  html = biome_or_prettier,
  json = biome_or_prettier,
  javascriptreact = biome_or_prettier,
  javascript = biome_or_prettier,
  markdown = biome_or_prettier,
  scss = biome_or_prettier,
  typescript = biome_or_prettier,
  typescriptreact = biome_or_prettier,
  vue = biome_or_prettier,
  yaml = biome_or_prettier,
}

return {
  {
    "stevearc/conform.nvim",
    event = {
      "BufReadPost",
      "BufNewFile",
    },
    cond = function()
      return not vim.g.vscode
    end,
    opts = {
      format_after_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        -- Disable autoformat for files in a certain path
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        if bufname:match("/node_modules/") then
          return
        end
        return { timeout_ms = 500, lsp_format = "fallback" }
      end,
      formatters_by_ft = formatters_by_ft,
      formatters = {
        sql_formatter = {
          command = "npx",
          args = { "sql-formatter" },
          stdin = true,
        },
      },
    },
  },
}
