{ config, user, ... }:

{
  xdg.configFile."mise".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/mise";
}
