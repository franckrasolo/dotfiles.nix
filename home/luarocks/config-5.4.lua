local luarocks_conf_dir = os_getenv("XDG_CONFIG_HOME") .. "/luarocks"
local luarocks_data_dir = os_getenv("XDG_DATA_HOME") .. "/luarocks"
local os_arch = "arm"

arch = "macosx-" .. os_arch
config_files = {
   user = {
      file = luarocks_conf_dir .. "/config-5.4.lua",
   }
}
home_tree = luarocks_data_dir
rocks_trees = {
   {
      name = "user",
      root = luarocks_data_dir
   }
}
processor = os_arch
target_cpu = os_arch
user_agent = "LuaRocks/3.11.1 " .. arch
