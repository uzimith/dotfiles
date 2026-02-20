return {
  {
    "smoka7/hop.nvim",
    lazy = false,
    config = function()
      local hop = require("hop")
      local directions = require("hop.hint").HintDirection
      hop.setup({
        keys = "hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB",
        case_insensitive = false,
      })
      vim.keymap.set("", "f", function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
      end, { remap = true })
      vim.keymap.set("", "F", function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
      end, { remap = true })
      vim.keymap.set("", ";k", function()
        hop.hint_vertical({ direction = directions.BEFORE_CURSOR })
      end, { remap = true })
      vim.keymap.set("", ";j", function()
        hop.hint_vertical({ direction = directions.AFTER_CURSOR })
      end, { remap = true })
      vim.keymap.set("", ";h", function()
        hop.hint_anywhere({ direction = directions.BEFORE_CURSOR, current_line_only = true })
      end, { remap = true })
      vim.keymap.set("", ";l", function()
        hop.hint_anywhere({ direction = directions.AFTER_CURSOR, current_line_only = true })
      end, { remap = true })
    end,
  },
}
