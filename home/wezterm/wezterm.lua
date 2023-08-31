local wezterm = require "wezterm"
local action = wezterm.action
local mod = "ALT|SHIFT"

return {
  font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold", italic = false }),
  font_size = 15.0,
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
  initial_cols = 186,
  initial_rows = 57,
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
