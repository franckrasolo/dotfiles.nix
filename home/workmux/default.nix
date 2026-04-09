{ config, user, ... }:

{
  xdg.configFile."workmux".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/workmux";
}
