local wezterm = require("wezterm")
local accent_colors = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]

local process_to_icon = {
  ["yazi"] = { wezterm.nerdfonts.md_duck, color = { fg = accent_colors.ansi[5] } },
  ["zellij"] = { wezterm.nerdfonts.md_hexagon_slice_6, color = { fg = accent_colors.ansi[4] } },
  ["zsh"] = { wezterm.nerdfonts.oct_terminal, color = { fg = "#A4A9BB" } },
}

return function(_)
  local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

  local function icon()
    return " 󰰮 "
  end

  tabline.setup {
    options = {
      icons_enabled = true,
      theme = "Overnight Slumber",
      color_overrides = {
        normal_mode = {
          a = {},
          b = { fg = "#A3C3AD" },
          c = {},
        },
        tab = {
          active = { bg = "#30463C" },
          inactive = {},
        }
      },
      section_separators = {
        left = wezterm.nerdfonts.ple_right_half_circle_thick,
        right = wezterm.nerdfonts.ple_left_half_circle_thick,
      },
      component_separators = {
        left = wezterm.nerdfonts.ple_right_half_circle_thin,
        right = wezterm.nerdfonts.ple_left_half_circle_thin,
      },
      tab_separators = {
        left = wezterm.nerdfonts.ple_right_half_circle_thick,
        right = wezterm.nerdfonts.ple_left_half_circle_thick,
      },
    },
    sections = {
      tabline_a = { icon },
      tabline_b = { "mode" },
      tabline_c = { " " },
      tab_active = {
        { Foreground = { Color = accent_colors.ansi[3] } },
        "index",
        { Foreground = { Color = accent_colors.foreground } },
        { "parent", max_length = 20, padding = 0 },
        "/",
        { "cwd", max_length = 20, padding = { left = 0, right = 1 } },
        { Foreground = { Color = accent_colors.ansi[3] } },
        { Text = wezterm.nerdfonts.ple_forwardslash_separator },
        { "process", icons_only = true, process_to_icon = process_to_icon, padding = { left = 1, right = 0 } },
      },
      tab_inactive = {
        { Foreground = { Color = accent_colors.ansi[6] } },
        "index",
        { Foreground = { Color = "#727272" } },
        { "parent", max_length = 20, padding = 0 },
        "/",
        { "cwd", max_length = 20, padding = { left = 0, right = 1 } },
        { Foreground = { Color = accent_colors.ansi[6] } },
        { Text = wezterm.nerdfonts.ple_forwardslash_separator },
        { Background = { Color = accent_colors.tab_bar.background } },
        { Foreground = { Color = "#727272" } },
        { "process", icons_only = true, process_to_icon = process_to_icon, padding = { left = 1, right = 0 } },
      },
      tabline_x = {},
      tabline_y = { { "datetime", style = "%a %d %b %Y %H:%M:%S", hour_to_icon = "" }, "battery" },
      tabline_z = {},
    },
    extensions = {},
  }
end
