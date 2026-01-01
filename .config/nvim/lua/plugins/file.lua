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
          ["Y"] = { "actions.copy_entry_path", mode = "n" },
          ["gy"] = {
            callback = function()
              local entry = require("oil").get_cursor_entry()
              local dir = require("oil").get_current_dir()
              if entry and dir then
                local full_path = dir .. entry.name
                local relative_path = vim.fn.fnamemodify(full_path, ":.")
                vim.fn.setreg("+", relative_path)
                vim.notify(relative_path, vim.log.levels.INFO)
              end
            end,
            mode = "n",
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
      require("other-nvim").setup({
        mappings = {
          {
            pattern = "/src/(.*?).ts$",
            target = "/src/%1.test.ts",
            context = "test",
          },
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
      vim.api.nvim_set_keymap("n", "<leader>ll", "<cmd>:Other<CR>", opts)
      vim.api.nvim_set_keymap("n", "<leader>ltn", "<cmd>:OtherTabNew<CR>", opts)
      vim.api.nvim_set_keymap("n", "<leader>lp", "<cmd>:OtherSplit<CR>", opts)
      vim.api.nvim_set_keymap("n", "<leader>lv", "<cmd>:OtherVSplit<CR>", opts)
      vim.api.nvim_set_keymap("n", "<leader>lc", "<cmd>:OtherClear<CR>", opts)
    end,
  },
}
