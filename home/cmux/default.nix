{ config, user, ... }:

{
  xdg.configFile."ghostty".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/cmux";
}
