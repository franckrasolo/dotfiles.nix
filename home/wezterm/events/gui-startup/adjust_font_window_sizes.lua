local wezterm = require("wezterm")

-- adjust font & window sizes on startup
wezterm.on("gui-startup", function(cmd)
  local screen = wezterm.gui.screens().active
  local _, _, mux_window = wezterm.mux.spawn_window(cmd or {})
  local gui_window = mux_window:gui_window()

  -- MacBook Pro 16" 2023
  if screen.width <= 3456 then
    local margin = 40
    local status_bar_height = 26

    gui_window:set_config_overrides { font_size = 18 }
    gui_window:set_inner_size(
        screen.width - 2 * margin,
        screen.height - status_bar_height - 2 * margin
    )
    gui_window:set_position(
        screen.x + margin,
        screen.y + status_bar_height + 15 + margin
    )
  else
    local margin = 10
    local height_ratio = 0.475

    gui_window:set_inner_size(
        screen.width / 2 - 2 * margin,
        (screen.height - margin) * height_ratio
    )
    gui_window:set_position(
        screen.x + margin,
        screen.y + (screen.height - margin) * (1 - height_ratio)
    )
  end
end)
