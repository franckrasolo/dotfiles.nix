{ config, user, ... }:

{
  xdg.configFile."opencode".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/opencode";
}
