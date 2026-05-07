
{ config, pkgs, user, ... }:

{
  home.packages = with pkgs; [
    zathura
  ];

  xdg.configFile."zathura".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/zathura";
}
