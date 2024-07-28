local wezterm = require "wezterm"
local action = wezterm.action
local mod = "ALT|SHIFT"

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

return {
  font = wezterm.font { family = "Cascadia Code", weight = "DemiBold", italic = false },
  font_size = 15.7,
--[[
  font = wezterm.font { family = "JetBrainsMono Nerd Font", weight = "DemiBold", italic = false },
  font = wezterm.font { family = "Monaspace Argon", weight = "DemiBold", italic = false, stretch = "UltraCondensed",
    harfbuzz_features = {
      'calt=1', 'clig=1', 'liga=1',
      'ss01=1', 'ss02=1', 'ss03=1', 'ss04=1', 'ss05=1', 'ss06=1', 'ss07=1', 'ss08=1', 'ss09=1',
    }
  },
  font_size = 15.0,
]]
  line_height = 1.075,

  color_scheme = "UltraDark",
  colors = {
    selection_bg = "#99CD8C",
    selection_fg = "black",

    copy_mode_inactive_highlight_bg = { Color = "#E8BF6A" },
    copy_mode_inactive_highlight_fg = { AnsiColor = "Black" },
  },
  freetype_load_target = "Light",
  freetype_render_target = "HorizontalLcd",

  text_background_opacity = 1.0,
  window_background_opacity = 0.875,
  window_decorations = "RESIZE",
  adjust_window_size_when_changing_font_size = false,
  native_macos_fullscreen_mode = true,
  window_padding = {
    left = "0px",
    right = "0px",
    top = "0px",
    bottom = "0px",
  },

  use_fancy_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  show_tabs_in_tab_bar = true,
  show_new_tab_button_in_tab_bar = true,

  enable_scroll_bar = false,
  scrollback_lines = 100000,

  send_composed_key_when_left_alt_is_pressed = true,

  keys = {
    {
      mods = "CMD|SHIFT",
      key = "K",
      action = action.Multiple {
        action.ClearScrollback "ScrollbackAndViewport",
        action.SendKey { mods = "CTRL", key = "L" },
      },
    },
    { mods = mod, key = "|", action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { mods = mod, key = "_", action = action.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { mods = mod, key = "LeftArrow", action = action.ActivatePaneDirection "Left" },
    { mods = mod, key = "RightArrow", action = action.ActivatePaneDirection "Right" },
    { mods = mod, key = "UpArrow", action = action.ActivatePaneDirection "Up" },
    { mods = mod, key = "DownArrow", action = action.ActivatePaneDirection "Down" },
    { mods = mod, key = "Enter", action = action.TogglePaneZoomState },
  }
}
