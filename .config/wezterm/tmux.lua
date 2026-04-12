local wezterm = require("wezterm")
local act = wezterm.action

local M = {}

function M.apply(config)
  config.leader = { key = "t", mods = "CTRL", timeout_milliseconds = 1000 }

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
    { key = "y", mods = "LEADER", action = act.ActivateCopyMode },
    { key = "p", mods = "LEADER", action = act.PasteFrom("Clipboard") },

    -- Search & Quick Select
    { key = "/", mods = "LEADER", action = act.Search("CurrentSelectionOrEmptyString") }, -- search
    { key = "s", mods = "LEADER", action = act.QuickSelect }, -- quick select

    -- Workspace
    { key = "w", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
    {
      key = "n",
      mods = "LEADER",
      action = act.PromptInputLine({
        description = "New workspace name:",
        action = wezterm.action_callback(function(window, pane, line)
          if line then
            window:perform_action(act.SwitchToWorkspace({ name = line }), pane)
          end
        end),
      }),
    },

    -- Misc
    { key = ":", mods = "LEADER|SHIFT", action = act.ActivateCommandPalette },
    { key = "r", mods = "LEADER", action = act.ReloadConfiguration },
  }

  config.key_tables = {
    copy_mode = {
      -- Movement
      { key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
      { key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
      { key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
      { key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },
      { key = "LeftArrow", mods = "NONE", action = act.CopyMode("MoveLeft") },
      { key = "DownArrow", mods = "NONE", action = act.CopyMode("MoveDown") },
      { key = "UpArrow", mods = "NONE", action = act.CopyMode("MoveUp") },
      { key = "RightArrow", mods = "NONE", action = act.CopyMode("MoveRight") },

      -- Word movement
      { key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
      { key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },
      { key = "e", mods = "NONE", action = act.CopyMode("MoveForwardWordEnd") },

      -- Line movement
      { key = "0", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
      { key = "$", mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },
      { key = "^", mods = "SHIFT", action = act.CopyMode("MoveToStartOfLineContent") },

      -- Page movement
      { key = "g", mods = "NONE", action = act.CopyMode("MoveToScrollbackTop") },
      { key = "G", mods = "SHIFT", action = act.CopyMode("MoveToScrollbackBottom") },
      { key = "u", mods = "CTRL", action = act.CopyMode("PageUp") },
      { key = "d", mods = "CTRL", action = act.CopyMode("PageDown") },

      -- Selection
      { key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
      { key = "V", mods = "SHIFT", action = act.CopyMode({ SetSelectionMode = "Line" }) },
      { key = "v", mods = "CTRL", action = act.CopyMode({ SetSelectionMode = "Block" }) },

      -- Copy and exit
      {
        key = "y",
        mods = "NONE",
        action = act.Multiple({
          { CopyTo = "ClipboardAndPrimarySelection" },
          { CopyMode = "Close" },
        }),
      },

      -- Exit copy mode
      { key = "q", mods = "NONE", action = act.CopyMode("Close") },
      { key = "Escape", mods = "NONE", action = act.CopyMode("Close") },

      -- Search
      { key = "/", mods = "NONE", action = act.Search("CurrentSelectionOrEmptyString") },
      { key = "n", mods = "NONE", action = act.CopyMode("NextMatch") },
      { key = "N", mods = "SHIFT", action = act.CopyMode("PriorMatch") },

      { key = " ", mods = "NONE", action = act.ActivateKeyTable({ name = "copy_mode_space", one_shot = true }) },
    },
  }
  config.key_tables.copy_mode_space = {
    { key = "h", mods = "NONE", action = act.CopyMode("MoveToStartOfLineContent") },
    { key = "l", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
  }

  local copy_mode = config.key_tables.copy_mode
  table.insert(copy_mode, { key = "J", mods = "SHIFT", action = act.CopyMode("PageDown") })
  table.insert(copy_mode, { key = "K", mods = "SHIFT", action = act.CopyMode("PageUp") })
end

return M
