local wezterm = require "wezterm"

-- adjust font & window size on startup
wezterm.on('gui-startup', function(cmd)
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

local config = wezterm.config_builder()
config:set_strict_mode(true)

config.automatically_reload_config = true
config.default_cursor_style = "BlinkingBlock"

config.font = wezterm.font { family = "Cascadia Code", weight = "DemiBold", italic = false }
config.font_size = 15.7

--[[
config.font = wezterm.font { family = "JetBrainsMono Nerd Font", weight = "DemiBold", italic = false },
config.font = wezterm.font { family = "Monaspace Argon", weight = "DemiBold", italic = false, stretch = "UltraCondensed",
    harfbuzz_features = {
      'calt=1', 'clig=1', 'liga=1',
      'ss01=1', 'ss02=1', 'ss03=1', 'ss04=1', 'ss05=1', 'ss06=1', 'ss07=1', 'ss08=1', 'ss09=1',
    }
  },
config.font_size = 15.0,
]]

config.line_height = 1.075

config.color_scheme = "UltraDark"
config.colors = {
  selection_bg = "#99CD8C",
  selection_fg = "black",

  copy_mode_inactive_highlight_bg = { Color = "#E8BF6A" },
  copy_mode_inactive_highlight_fg = { AnsiColor = "Black" },
}

config.freetype_load_target = "Light"
config.freetype_render_target = "HorizontalLcd"

config.text_background_opacity = 1.0
config.window_background_opacity = 0.875
config.window_decorations = "RESIZE"
config.adjust_window_size_when_changing_font_size = false
config.native_macos_fullscreen_mode = true
config.window_padding = {
  left = "0px",
  right = "0px",
  top = "0px",
  bottom = "0px",
}

config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tabs_in_tab_bar = true
config.show_new_tab_button_in_tab_bar = true

config.enable_scroll_bar = false
config.scrollback_lines = 100000

require("key_bindings")(config)

return config
