-- append LuaRocks package paths to WezTerm/Lua's package paths
local luarocks = "/etc/profiles/per-user/" .. os.getenv("USER") .. "/bin/luarocks"

function execute(prog)
  return io.popen(prog):read("*a")
end

package.path  = package.path  .. ";" .. execute(luarocks .. " path --lr-path"):gsub("\n", "")
package.cpath = package.cpath .. ";" .. execute(luarocks .. " path --lr-cpath"):gsub("\n", "")

local config = require("wezterm").config_builder()
config:set_strict_mode(true)
config.automatically_reload_config = true
config.scrollback_lines = 100000

require("config.appearance")(config)
require("config.key_bindings")(config)
require("config.typography")(config)
require("plugins.tabline")(config)

require("events.gui-startup.adjust_font_window_sizes")
require("events.update-status.remove_tabline_when_presenting")
return config
