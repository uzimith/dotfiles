local wezterm = require 'wezterm'
local act = wezterm.action

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'Solarized Light (Gogh)'
config.default_prog = { '/opt/homebrew/bin/fish' }

-- Leader key: Ctrl+r (matching tmux.conf)
config.leader = { key = 'r', mods = 'CTRL', timeout_milliseconds = 1000 }

-- Tab index starts from 1 (base-index 1)
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

-- Tab title shows current directory name
wezterm.on('format-tab-title', function(tab)
  local pane = tab.active_pane
  local cwd = pane.current_working_dir
  local title = tab.tab_index + 1 .. ':'
  if cwd then
    local path = cwd.file_path
    title = title .. path:match('[^/]+$')
  else
    title = title .. pane.title
  end
  return ' ' .. title .. ' '
end)

config.keys = {
  -- Send Ctrl+r when pressing Leader + r
  { key = 'r', mods = 'LEADER', action = act.SendKey { key = 'r', mods = 'CTRL' } },

  -- Pane splitting (Leader+s: vertical, Leader+v: horizontal)
  { key = 's', mods = 'LEADER', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 's', mods = 'LEADER|CTRL', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'v', mods = 'LEADER', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'v', mods = 'LEADER|CTRL', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },

  -- Pane navigation (Ctrl+h/j/k/l without leader, like vim-tmux-navigator)
  { key = 'h', mods = 'CTRL', action = act.ActivatePaneDirection 'Left' },
  { key = 'j', mods = 'CTRL', action = act.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'CTRL', action = act.ActivatePaneDirection 'Up' },
  { key = 'l', mods = 'CTRL', action = act.ActivatePaneDirection 'Right' },

  -- Pane resize (Leader + Ctrl+h/j/k/l)
  { key = 'h', mods = 'LEADER|CTRL', action = act.AdjustPaneSize { 'Left', 6 } },
  { key = 'l', mods = 'LEADER|CTRL', action = act.AdjustPaneSize { 'Right', 6 } },
  { key = 'j', mods = 'LEADER|CTRL', action = act.AdjustPaneSize { 'Down', 6 } },
  { key = 'k', mods = 'LEADER|CTRL', action = act.AdjustPaneSize { 'Up', 6 } },

  -- Zoom pane (Leader + Ctrl+z)
  { key = 'z', mods = 'LEADER|CTRL', action = act.TogglePaneZoomState },

  -- Close pane (Leader+K or Leader+Ctrl+x)
  { key = 'K', mods = 'LEADER|SHIFT', action = act.CloseCurrentPane { confirm = true } },
  { key = 'x', mods = 'LEADER|CTRL', action = act.CloseCurrentPane { confirm = true } },

  -- Close tab (Leader+X)
  { key = 'X', mods = 'LEADER|SHIFT', action = act.CloseCurrentTab { confirm = true } },

  -- New tab (Leader+c / Leader+Ctrl+c)
  { key = 'c', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'c', mods = 'LEADER|CTRL', action = act.SpawnTab 'CurrentPaneDomain' },

  -- Tab navigation (Leader+j: next, Leader+k: previous)
  { key = 'j', mods = 'LEADER', action = act.ActivateTabRelative(1) },
  { key = 'k', mods = 'LEADER', action = act.ActivateTabRelative(-1) },

  -- Tab navigation (Ctrl+Tab / Ctrl+Shift+Tab)
  { key = 'Tab', mods = 'CTRL', action = act.ActivateTabRelative(1) },
  { key = 'Tab', mods = 'CTRL|SHIFT', action = act.ActivateTabRelative(-1) },

  -- Swap window (Leader+h: left, Leader+l: right) — like tmux swap-window
  { key = 'h', mods = 'LEADER', action = act.MoveTabRelative(-1) },
  { key = 'l', mods = 'LEADER', action = act.MoveTabRelative(1) },

  -- Tab by number (Leader + 1-9)
  { key = '1', mods = 'LEADER', action = act.ActivateTab(0) },
  { key = '2', mods = 'LEADER', action = act.ActivateTab(1) },
  { key = '3', mods = 'LEADER', action = act.ActivateTab(2) },
  { key = '4', mods = 'LEADER', action = act.ActivateTab(3) },
  { key = '5', mods = 'LEADER', action = act.ActivateTab(4) },
  { key = '6', mods = 'LEADER', action = act.ActivateTab(5) },
  { key = '7', mods = 'LEADER', action = act.ActivateTab(6) },
  { key = '8', mods = 'LEADER', action = act.ActivateTab(7) },
  { key = '9', mods = 'LEADER', action = act.ActivateTab(8) },

  -- Copy mode (Leader + Ctrl+y)
  { key = 'y', mods = 'LEADER|CTRL', action = act.ActivateCopyMode },

  -- Paste (Leader + Ctrl+p)
  { key = 'p', mods = 'LEADER|CTRL', action = act.PasteFrom 'Clipboard' },

  -- Pane display (Leader+i)
  { key = 'i', mods = 'LEADER', action = act.PaneSelect {} },
}

-- Copy mode key table (vi mode)
config.key_tables = {
  copy_mode = wezterm.gui.default_key_tables().copy_mode,
}

-- Add custom copy mode bindings
local copy_mode = config.key_tables.copy_mode
table.insert(copy_mode, { key = 'J', mods = 'SHIFT', action = act.CopyMode 'PageDown' })
table.insert(copy_mode, { key = 'K', mods = 'SHIFT', action = act.CopyMode 'PageUp' })

return config
