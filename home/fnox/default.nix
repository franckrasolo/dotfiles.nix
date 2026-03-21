{ config, user, ... }:

{
  xdg.configFile."fnox".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/fnox";
}
