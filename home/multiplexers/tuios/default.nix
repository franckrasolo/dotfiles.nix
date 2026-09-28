
{ config, user, ... }:

{
  xdg.configFile."tuios/config.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/multiplexers/tuios/config.toml";
}
