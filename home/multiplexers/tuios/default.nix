
{ config, user, ... }:

{
  xdg.configFile."tuios".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/multiplexers/tuios";
}
