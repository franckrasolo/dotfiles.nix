{ config, pkgs, ... }:

let
  lua_version = "5.4";

  luaEnv = pkgs.unstable.lua5_4_compat.withPackages (
    ps: with ps; [
      luasocket
      moonscript
      penlight
    ]
  );
in
{
  home.packages = with pkgs.unstable; [
    luaEnv
    lua54Packages.luarocks
  ];

  home.sessionVariables = {
    LUA_PATH = "${luaEnv}/share/lua/${lua_version}/?.lua;${luaEnv}/share/lua/${lua_version}/?/init.lua";
    LUA_CPATH = "${luaEnv}/lib/lua/${lua_version}/?.so";
  };

  xdg.configFile."luarocks/config-${lua_version}.lua".text = import ./config.nix {
    inherit config luaEnv;
  };

  xdg.configFile."luarocks/luarocks.lua".source = ./luarocks.lua;
}
