return {
  {
    "lambdalisue/vim-file-protocol",
    lazy = false,
  },
  {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = function()
      require("oil").setup({
        keymaps = {
          ["g?"] = { "actions.show_help", mode = "n" },
          ["<CR>"] = "actions.select",
          ["<C-s>"] = { "actions.select", opts = { vertical = true } },
          ["<C-t>"] = { "actions.select", opts = { tab = true } },
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = { "actions.close", mode = "n" },
          ["<C-l>"] = "actions.refresh",
          ["<C-h>"] = { "actions.parent", mode = "n" },
          ["h"] = { "actions.parent", mode = "n" },
          ["gy"] = { "actions.copy_entry_path", mode = "n" },
          ["Y"] = {
            callback = function()
              require("oil_copy_paths")("")
            end,
            mode = { "n", "v" },
          },
          ["<leader>a"] = {
            callback = function()
              require("oil_copy_paths")("@")
            end,
            mode = { "n", "v" },
          },
          ["_"] = { "actions.open_cwd", mode = "n" },
          ["`"] = { "actions.cd", mode = "n" },
          ["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
          ["gs"] = { "actions.change_sort", mode = "n" },
          ["gx"] = "actions.open_external",
          ["g."] = { "actions.toggle_hidden", mode = "n" },
          ["g\\"] = { "actions.toggle_trash", mode = "n" },
        },
        use_default_keymaps = false,
      })

      local opts = { silent = true, noremap = true }
      vim.keymap.set("n", "<Leader>ff", "<Cmd>Oil<CR>", opts)
    end,
  },
  {
    "rgroli/other.nvim",
    lazy = false,
    config = function()
      local function src(ext)
        return function(file)
          if file:match("%.test%.[^.]+$") then
            return nil
          end
          local base, name = file:match("(.*)/src/(.*)%." .. ext .. "$")
          if base and name then
            return { base, name }
          end
          return nil
        end
      end

      local function target(ext)
        return {
          { target = "%1/src/%2.test." .. ext, context = "test" },
          { target = "%1/tests/%2.test." .. ext, context = "test" },
          { target = "%1/src/%2." .. ext, context = "src" },
        }
      end
      local other = require("other-nvim")
      other.setup({
        mappings = {
          { pattern = src("ts"), target = target("ts") },
          { pattern = "(.*)/tests/(.*).test.ts$", target = target("ts") },
          { pattern = "(.*)/src/(.*).test.ts$", target = target("ts") },

          { pattern = src("tsx"), target = target("tsx") },
          { pattern = "(.*)/tests/(.*).test.tsx$", target = target("tsx") },
          { pattern = "(.*)/src/(.*).test.tsx$", target = target("tsx") },
        },
        transformers = {},
        style = {
          border = "single",
          seperator = "|",
          width = 0.7,
          minHeight = 2,
        },
      })

      local opts = { silent = true, noremap = true }
      vim.keymap.set("n", "<leader>l", other.open, opts)
      vim.keymap.set("n", "<leader>L", function()
        other.clear()
        other.open()
      end, opts)
    end,
  },
}
