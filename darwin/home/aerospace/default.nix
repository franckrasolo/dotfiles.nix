{ config, user, ... }:

{
  xdg.configFile."aerospace".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/darwin/home/aerospace";
}
