local wezterm = require("wezterm")

local M = {}

function M.apply(config)
  config.color_scheme = "Solarized Light (Gogh)"
  config.font = wezterm.font("HackGen35 Console NFJ")
  config.tab_bar_at_bottom = true
  config.use_fancy_tab_bar = false
  config.show_new_tab_button_in_tab_bar = false
  config.tab_max_width = 32

  wezterm.on("format-tab-title", function(tab, tabs, panes, cfg, hover, max_width)
    local index = tab.tab_index + 1
    local title = tab.active_pane.title
    local max_chars = 20
    local char_len = utf8.len(title) or 0
    if char_len > max_chars then
      local byte_pos = utf8.offset(title, max_chars - 1) or #title
      title = title:sub(1, byte_pos - 1) .. ".."
    end
    return string.format(" %d:%s ", index, title)
  end)

  wezterm.on("update-status", function(window, pane)
    local workspace = window:active_workspace()
    local date = wezterm.strftime("%Y/%m/%d %H:%M")
    local key_table = window:active_key_table() or ""

    local left = {
      { Foreground = { Color = "#7aa2f7" } },
      { Background = { Color = "#1a1b26" } },
      { Text = "  " .. workspace .. " " },
    }
    if key_table ~= "" then
      table.insert(left, { Foreground = { Color = "#e0af68" } })
      table.insert(left, { Background = { Color = "#1a1b26" } })
      table.insert(left, { Text = " [" .. key_table .. "]" })
    end

    window:set_left_status(wezterm.format(left))

    window:set_right_status(wezterm.format({
      { Foreground = { Color = "#c6c6c6" } },
      { Text = " " .. date .. " " },
    }))
  end)
end

return M
