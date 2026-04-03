local wezterm = require("wezterm")

local M = {}

function M.apply(config)
  config.color_scheme = "Solarized Light (Gogh)"
  config.font = wezterm.font("HackGen35 Console NFJ")
  config.default_prog = { "/opt/homebrew/bin/fish" }
  config.tab_bar_at_bottom = true
  config.use_fancy_tab_bar = false

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
end

return M
