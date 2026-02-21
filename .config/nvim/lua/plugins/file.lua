local function copy_entry_paths(prefix)
  local oil = require("oil")
  local dir = oil.get_current_dir()
  if not dir then
    return
  end
  local mode = vim.fn.mode()
  if mode == "v" or mode == "V" then
    local start_line = vim.fn.line("v")
    local end_line = vim.fn.line(".")
    if start_line > end_line then
      start_line, end_line = end_line, start_line
    end
    local paths = {}
    for lnum = start_line, end_line do
      local entry = oil.get_entry_on_line(0, lnum)
      if entry then
        local full_path = dir .. entry.name
        table.insert(paths, prefix .. vim.fn.fnamemodify(full_path, ":."))
      end
    end
    if #paths > 0 then
      local result = table.concat(paths, "\n")
      vim.fn.setreg("+", result)
      vim.notify(#paths .. " paths copied", vim.log.levels.INFO)
    end
    vim.api.nvim_input("<Esc>")
  else
    local entry = oil.get_cursor_entry()
    if entry then
      local full_path = dir .. entry.name
      local relative_path = prefix .. vim.fn.fnamemodify(full_path, ":.")
      vim.fn.setreg("+", relative_path)
      vim.notify(relative_path, vim.log.levels.INFO)
    end
  end
end

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
          ["<C-g>"] = "actions.refresh",
          ["<C-h>"] = { "actions.parent", mode = "n" },
          ["-"] = { "actions.parent", mode = "n" },
          ["gy"] = { "actions.copy_entry_path", mode = "n" },
          ["Y"] = {
            callback = function()
              copy_entry_paths("")
            end,
            mode = { "n", "v" },
          },
          ["<leader>a"] = {
            callback = function()
              copy_entry_paths("@")
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
  {
    "mikavilpas/yazi.nvim",
    cmd = "Yazi",
    opts = {},
    keys = {
      { "sd", "<cmd>Yazi<CR>", desc = "Open Yazi", mode = "n" },
      {
        "sf",
        function()
          local git_root = vim.fs.root(0, ".git")
          require("yazi").yazi(nil, git_root or vim.fn.getcwd())
        end,
        desc = "Open Yazi at git root",
        mode = "n",
      },
    },
  },
}
