return function(config)
  local wezterm = require("wezterm")

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

  config.freetype_load_target = "Light"
  config.freetype_render_target = "HorizontalLcd"
end
