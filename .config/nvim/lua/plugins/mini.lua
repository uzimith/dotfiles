return {
    {
      "echasnovski/mini.nvim",
      lazy = false,
      config = function()
        vim.api.nvim_create_autocmd({ "InsertEnter" }, {
          pattern = "*",
          callback = function()
            -- ai
            require("mini.ai").setup({})
            -- comment
            require("mini.comment").setup({})
            -- splitjoin
            require("mini.splitjoin").setup({})
            -- autopair
            require("mini.pairs").setup({})
            -- surround
            require("mini.surround").setup({
              mappings = {
                add = "sa",
                delete = "sd",
                find = "sf",
                find_left = "sF",
                highlight = "sh",
                replace = "sc",
                update_n_lines = "sn",
                suffix_last = "l",
                suffix_next = "n",
              },
            })
          end,
          once = true,
        })
      end,
    },
  }