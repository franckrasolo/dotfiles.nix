return function(config)
  config.default_cursor_style = "BlinkingBlock"

  config.color_scheme = "UltraDark"
  config.colors = {
    selection_bg = "#99CD8C",
    selection_fg = "black",

    copy_mode_inactive_highlight_bg = { Color = "#E8BF6A" },
    copy_mode_inactive_highlight_fg = { AnsiColor = "Black" },
  }

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
  config.tab_max_width = 32
  config.unzoom_on_switch_pane = false

  config.enable_scroll_bar = false
end
