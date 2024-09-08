local wezterm = require("wezterm")

return function(config)
  local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
  local accent_colors = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]

  local function icon()
    return "  "
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
      tabline_a = {},
      tabline_b = { icon },
      tabline_c = { " " },
      tab_active = {
        { Attribute = { Intensity = "Bold" } },
        { Foreground = { Color = accent_colors.ansi[3] } },
        "tab_index",
        "ResetAttributes",
        { Foreground = { Color = accent_colors.foreground } },
        { "parent", max_length = 20, padding = 0 },
        "/",
        { Attribute = { Intensity = "Bold" } },
        { "cwd", max_length = 20, padding = { left = 0, right = 1 } },
      },
      tab_inactive = {
        { Foreground = { Color = accent_colors.ansi[6] } },
        "tab_index",
        "ResetAttributes",
        { "process", padding = { left = 0, right = 1 } }
      },
      tabline_x = {},
      tabline_y = { { "datetime", style = "%a %d %b %Y %H:%M:%S", hour_to_icon = "" }, "battery" },
      tabline_z = {},
    },
    extensions = {},
  }

  config.colors["tab_bar"] = {
    background = require("tabline.config").colors.normal_mode.c.bg,
  }
  config.status_update_interval = 250
end
