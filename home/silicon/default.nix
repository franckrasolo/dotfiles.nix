{ pkgs, ... }:

{
  home.packages = [ pkgs.unstable.silicon ];

  xdg.configFile."silicon/config".source = ./config;
}
