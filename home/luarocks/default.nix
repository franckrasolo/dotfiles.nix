{ config, pkgs, ... }:

with pkgs.unstable;
let
  lua = lua5_4_compat;

  luaVersion = "5.4";

  luaEnv = lua.withPackages (
    ps: with ps; [
      (callPackage ./luafun.nix { inherit lua; })
      luasocket
      moonscript
      penlight
    ]
  );
in
{
  home.packages = [
    luaEnv
    lua54Packages.luarocks
  ];

  home.sessionVariables = {
    LUA_PATH = "${luaEnv}/share/lua/${luaVersion}/?.lua;${luaEnv}/share/lua/${luaVersion}/?/init.lua";
    LUA_CPATH = "${luaEnv}/lib/lua/${luaVersion}/?.so";
  };

  xdg.configFile."luarocks/config-${luaVersion}.lua".text = import ./config.nix {
    inherit config luaEnv;
  };

  xdg.configFile."luarocks/luarocks.lua".source = ./luarocks.lua;
}
