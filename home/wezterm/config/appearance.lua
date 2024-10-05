local colour_scheme = require("wezterm").color.get_builtin_schemes()["UltraDark"]
colour_scheme.background = "black"
colour_scheme.selection_bg = "#34bf91"
colour_scheme.selection_fg = "#DFFFE6"
colour_scheme.copy_mode_inactive_highlight_bg = { Color = colour_scheme.ansi[4] }
colour_scheme.copy_mode_inactive_highlight_fg = { Color = colour_scheme.brights[1] }

return function(config)
  config.default_cursor_style = "BlinkingBlock"

  config.color_schemes = {
    ["UltraDarker"] = colour_scheme,
  }
  config.color_scheme = "UltraDarker"

  -- https://sw.kovidgoyal.net/kitty/graphics-protocol/
  -- https://github.com/wez/wezterm/issues/986
  -- https://github.com/zellij-org/zellij/issues/2814
  config.enable_kitty_graphics = true
  config.text_background_opacity = 1.0
  config.window_background_opacity = 0.875
  config.window_decorations = "RESIZE"
  config.adjust_window_size_when_changing_font_size = false
  config.native_macos_fullscreen_mode = true
  config.window_padding = {
    left   = "0px",
    right  = "0px",
    top    = "0px",
    bottom = "0px",
  }

  config.enable_tab_bar = true
  config.use_fancy_tab_bar = false
  config.hide_tab_bar_if_only_one_tab = false
  config.show_tabs_in_tab_bar = true
  config.show_new_tab_button_in_tab_bar = false
  config.tab_bar_at_bottom = false
  config.tab_max_width = 80
  config.unzoom_on_switch_pane = false

  config.enable_scroll_bar = false
end
