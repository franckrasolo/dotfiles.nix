local wezterm = require("wezterm")

wezterm.on("update-status", function(window, _)
  if not window:is_focused() then return end

  local process_info = window:active_tab():active_pane():get_foreground_process_info()

  if process_info.argv and string.find(table.concat(process_info["argv"]), "present") then
    local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
    tabline.setup {
      options = {},
      sections = {
        tabline_a = {},
        tabline_b = {},
        tabline_c = {},
        tab_active = {},
        tab_inactive = {},
        tabline_x = {},
        tabline_y = {},
        tabline_z = {},
      },
      extensions = {},
    }
    window:set_config_overrides { colors = { tab_bar = { background = "#01010F" } } }
  else
    require("plugins.tabline")(window:effective_config())
    window:set_config_overrides {
      colors = {
        tab_bar = { background = require("tabline.config").colors.normal_mode.c.bg }
      }
    }
  end
end)
