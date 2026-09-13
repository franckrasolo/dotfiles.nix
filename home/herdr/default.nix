{ config, user, ... }:

{
  xdg.configFile."herdr".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/herdr";
}
