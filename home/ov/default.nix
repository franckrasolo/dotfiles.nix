{ config, pkgs, user, ... }:

{
  home.packages = with pkgs.unstable; [
    ov
  ];

  xdg.configFile."ov/config.yaml".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/ov/config.yaml";
}
