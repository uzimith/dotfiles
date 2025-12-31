return {
  "monaqa/dial.nvim",
  cond = function()
    return not vim.g.vscode
  end,
  lazy = false,
  config = function()
    local augend = require("dial.augend")
    require("dial.config").augends:register_group({
      default = {
        augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
        augend.integer.alias.decimal_int,
        augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
        augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
        augend.date.alias["%Y-%m-%d"],
        augend.date.alias["%m/%d"],
        augend.date.alias["%-m/%-d"],
        augend.date.alias["%Y年%-m月%-d日"],
        augend.date.alias["%H:%M:%S"],
        augend.date.alias["%H:%M"],
        augend.constant.alias.bool, -- true <-> false
        augend.constant.alias.Bool, -- true <-> false
        augend.semver.alias.semver,
        augend.constant.new({
          elements = { "&&", "||" },
          word = false,
          cyclic = true,
        }),
        augend.constant.new({
          elements = { "==", "!=" },
          word = false,
          cyclic = true,
        }),
        augend.constant.new({
          elements = { "dev", "stage", "prod" },
          word = true,
          cyclic = true,
        }),
      },
    })

    vim.keymap.set("n", "<C-a>", function()
      require("dial.map").manipulate("increment", "normal")
    end)
    vim.keymap.set("n", "<C-x>", function()
      require("dial.map").manipulate("decrement", "normal")
    end)
    vim.keymap.set("n", "g<C-a>", function()
      require("dial.map").manipulate("increment", "gnormal")
    end)
    vim.keymap.set("n", "g<C-x>", function()
      require("dial.map").manipulate("decrement", "gnormal")
    end)
    vim.keymap.set("x", "<C-a>", function()
      require("dial.map").manipulate("increment", "visual")
    end)
    vim.keymap.set("x", "<C-x>", function()
      require("dial.map").manipulate("decrement", "visual")
    end)
    vim.keymap.set("x", "g<C-a>", function()
      require("dial.map").manipulate("increment", "gvisual")
    end)
    vim.keymap.set("x", "g<C-x>", function()
      require("dial.map").manipulate("decrement", "gvisual")
    end)
  end,
}
