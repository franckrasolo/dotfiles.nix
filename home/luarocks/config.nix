{ config, luaEnv }:

''
  local luarocks_conf_dir = "${config.xdg.configHome}/luarocks"
  local luarocks_data_dir = "${config.xdg.dataHome}/luarocks"
  local os_arch = "arm"

  arch = "macosx-" .. os_arch
  config_files = {
    user = {
        file = luarocks_conf_dir .. "/config-5.4.lua",
    }
  }
  home_tree = luarocks_data_dir
  homeconfdir = luarocks_conf_dir
  local_by_default = true
  check_certificates = true

  rocks_trees = {
    {
        name = "nix-env",
        root = "${luaEnv}"
    },
    {
        name = "user",
        root = luarocks_data_dir
    }
  }
  processor = os_arch
  target_cpu = os_arch
  lua_interpreter = "lua"
  user_agent = "LuaRocks/3.11.1 " .. arch

  variables = {
    LUA_INCDIR = "${luaEnv}/include",
    LUA_LIBDIR = "${luaEnv}/lib"
  }
''
