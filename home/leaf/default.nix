{ config, user, ... }:

{
  xdg.configFile."leaf".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/leaf";
}
