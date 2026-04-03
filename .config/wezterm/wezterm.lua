local wezterm = require 'wezterm'
local act = wezterm.action

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'Solarized Light (Gogh)'

-- tmux-like leader key: Ctrl+t
config.leader = { key = 't', mods = 'CTRL', timeout_milliseconds = 1000 }

config.keys = {
  -- Send Ctrl+t when pressing Leader + t
  { key = 't', mods = 'LEADER', action = act.SendKey { key = 't', mods = 'CTRL' } },

  -- Pane splitting
  { key = '%', mods = 'LEADER|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = '"', mods = 'LEADER|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },

  -- Pane navigation (vim-style)
  { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
  { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
  { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },

  -- Pane resize
  { key = 'H', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize { 'Left', 5 } },
  { key = 'J', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize { 'Down', 5 } },
  { key = 'K', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize { 'Up', 5 } },
  { key = 'L', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize { 'Right', 5 } },

  -- Close pane
  { key = 'x', mods = 'LEADER', action = act.CloseCurrentPane { confirm = true } },

  -- Tab (window in tmux terms)
  { key = 'c', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'n', mods = 'LEADER', action = act.ActivateTabRelative(1) },
  { key = 'p', mods = 'LEADER', action = act.ActivateTabRelative(-1) },

  -- Tab by number (Leader + 0-9)
  { key = '0', mods = 'LEADER', action = act.ActivateTab(0) },
  { key = '1', mods = 'LEADER', action = act.ActivateTab(1) },
  { key = '2', mods = 'LEADER', action = act.ActivateTab(2) },
  { key = '3', mods = 'LEADER', action = act.ActivateTab(3) },
  { key = '4', mods = 'LEADER', action = act.ActivateTab(4) },
  { key = '5', mods = 'LEADER', action = act.ActivateTab(5) },
  { key = '6', mods = 'LEADER', action = act.ActivateTab(6) },
  { key = '7', mods = 'LEADER', action = act.ActivateTab(7) },
  { key = '8', mods = 'LEADER', action = act.ActivateTab(8) },
  { key = '9', mods = 'LEADER', action = act.ActivateTab(9) },

  -- Zoom pane (toggle fullscreen for pane)
  { key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState },

  -- Copy mode (like tmux copy mode)
  { key = '[', mods = 'LEADER', action = act.ActivateCopyMode },

  -- Detach (close tab)
  { key = 'd', mods = 'LEADER', action = act.DetachDomain 'CurrentPaneDomain' },
}

return config
