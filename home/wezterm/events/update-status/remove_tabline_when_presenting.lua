require("fun")()

local function search(item, key, acc)
  local result = acc or {}
  if type(item) ~= "table" then return result end
  if item[key] then table.insert(result, item[key]) end
  for _, v in pairs(item) do search(v, key, result) end
  return result
end

local wezterm = require("wezterm")

wezterm.on("update-status", function(window, _)
  if not window:is_focused() then return end

  local process_info = window:active_tab():active_pane():get_foreground_process_info()

  local function predicate(x)
    return string.find(x, ".+present") or string.find(x, "neo")
  end

  if process_info and length(grep(predicate, search(process_info, "executable"))) > 0 then
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
