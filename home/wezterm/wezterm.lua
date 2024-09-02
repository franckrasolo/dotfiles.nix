local config = require("wezterm").config_builder()
config:set_strict_mode(true)
config.automatically_reload_config = true
config.scrollback_lines = 100000

require("appearance")(config)
require("key_bindings")(config)
require("typography")(config)
require("plugins.tabline")(config)

require("events.gui-startup.adjust_font_window_sizes")
return config
