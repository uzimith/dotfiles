local wezterm = require("wezterm")
local appearance = require("appearance")
local tmux = require("tmux")

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

appearance.apply(config)
tmux.apply(config)

return config
