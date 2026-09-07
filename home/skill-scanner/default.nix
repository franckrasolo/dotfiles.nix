{ config, user, ... }:

{
  xdg.configFile."skill-scanner".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/skill-scanner";
}
