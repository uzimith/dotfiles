return {
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    cond = function()
      return not vim.g.vscode
    end,
    config = function()
      local function quickfixcount()
        local qflist = vim.fn.getqflist({ idx = 0, size = 0 })
        if qflist.size == 0 then
          return ""
        end
        return "Q:[" .. qflist.idx .. "/" .. qflist.size .. "]"
      end

      local function loclistcount()
        local loclist = vim.fn.getloclist(0, { idx = 0, size = 0 })
        if loclist.size == 0 then
          return ""
        end
        return "L:[" .. loclist.idx .. "/" .. loclist.size .. "]"
      end

      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "solarized_light",
          component_separators = { left = "｜", right = "｜" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            "NvimTree",
            "statusline",
            "winbar",
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = { "diff", "diagnostics", "filename" },
          lualine_x = { "lsp_status", "encoding", "fileformat", "filetype" },
          lualine_y = { quickfixcount, loclistcount, "searchcount", "progress" },
          lualine_z = { "location", "%L" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "mode", "branch", "diff", "diagnostics", "filename" },
          lualine_x = { "lsp_status", "encoding", "fileformat", "filetype", "progress", "location" },
          lualine_y = { "%L" },
          lualine_z = {},
        },
        tabline = {
          lualine_a = {
            {
              "tabs",
              tab_max_length = 40,
              max_length = vim.o.columns / 3,
              mode = 1,
              path = 0,
              symbols = {
                modified = " ●",
                alternate_file = "#",
                directory = "",
              },
              tabs_color = {},
            },
          },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      })
    end,
  },
  {
    "Bekaboo/dropbar.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("dropbar").setup({})
      local dropbar_api = require("dropbar.api")
      vim.keymap.set("n", ";;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
      vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
      vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
    end,
  },
}
