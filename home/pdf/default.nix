
{ config, pkgs, user, ... }:

{
  home.packages = with pkgs.unstable; [
    # zathura
  ];

  xdg.configFile."zathura".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/pdf";
}
