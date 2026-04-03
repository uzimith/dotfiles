local wezterm = require("wezterm")
local act = wezterm.action

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = "Solarized Light (Gogh)"
config.font = wezterm.font("HackGen35 Console NFJ")
config.default_prog = { "/opt/homebrew/bin/fish" }

-- Leader key: Ctrl+t
config.leader = { key = "t", mods = "CTRL", timeout_milliseconds = 1000 }

-- Tab index starts from 1 (base-index 1)
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

-- Tab title shows current directory name
wezterm.on("format-tab-title", function(tab)
  local pane = tab.active_pane
  local cwd = pane.current_working_dir
  local title = tab.tab_index + 1 .. ":"
  if cwd then
    local path = cwd.file_path
    title = title .. path:match("[^/]+$")
  else
    title = title .. pane.title
  end
  return " " .. title .. " "
end)

config.keys = {
  -- Passthrough
  { key = "t", mods = "LEADER", action = act.SendKey({ key = "t", mods = "CTRL" }) },

  -- Pane
  { key = "s", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "s", mods = "LEADER|CTRL", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "v", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "v", mods = "LEADER|CTRL", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "h", mods = "CTRL", action = act.ActivatePaneDirection("Left") },
  { key = "j", mods = "CTRL", action = act.ActivatePaneDirection("Down") },
  { key = "k", mods = "CTRL", action = act.ActivatePaneDirection("Up") },
  { key = "l", mods = "CTRL", action = act.ActivatePaneDirection("Right") },
  { key = "h", mods = "LEADER|CTRL", action = act.AdjustPaneSize({ "Left", 6 }) },
  { key = "l", mods = "LEADER|CTRL", action = act.AdjustPaneSize({ "Right", 6 }) },
  { key = "j", mods = "LEADER|CTRL", action = act.AdjustPaneSize({ "Down", 6 }) },
  { key = "k", mods = "LEADER|CTRL", action = act.AdjustPaneSize({ "Up", 6 }) },
  { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
  { key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
  { key = "i", mods = "LEADER", action = act.PaneSelect({}) },

  -- Tab
  { key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "j", mods = "LEADER", action = act.ActivateTabRelative(1) },
  { key = "k", mods = "LEADER", action = act.ActivateTabRelative(-1) },
  { key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
  { key = "Tab", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },
  { key = "h", mods = "LEADER", action = act.MoveTabRelative(-1) },
  { key = "l", mods = "LEADER", action = act.MoveTabRelative(1) },
  { key = "x", mods = "LEADER|SHIFT", action = act.CloseCurrentTab({ confirm = true }) },
  { key = "1", mods = "LEADER", action = act.ActivateTab(0) },
  { key = "2", mods = "LEADER", action = act.ActivateTab(1) },
  { key = "3", mods = "LEADER", action = act.ActivateTab(2) },
  { key = "4", mods = "LEADER", action = act.ActivateTab(3) },
  { key = "5", mods = "LEADER", action = act.ActivateTab(4) },
  { key = "6", mods = "LEADER", action = act.ActivateTab(5) },
  { key = "7", mods = "LEADER", action = act.ActivateTab(6) },
  { key = "8", mods = "LEADER", action = act.ActivateTab(7) },
  { key = "9", mods = "LEADER", action = act.ActivateTab(8) },

  -- Copy/Paste
  { key = "y", mods = "LEADER|CTRL", action = act.ActivateCopyMode },
  { key = "p", mods = "LEADER|CTRL", action = act.PasteFrom("Clipboard") },
}

-- Copy mode key table (vi mode)
config.key_tables = {
  copy_mode = wezterm.gui.default_key_tables().copy_mode,
}

-- Add custom copy mode bindings
local copy_mode = config.key_tables.copy_mode
table.insert(copy_mode, { key = "J", mods = "SHIFT", action = act.CopyMode("PageDown") })
table.insert(copy_mode, { key = "K", mods = "SHIFT", action = act.CopyMode("PageUp") })

return config
