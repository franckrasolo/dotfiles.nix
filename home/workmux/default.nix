{ config, user, ... }:

{
  home.file.".config/workmux".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/workmux";
}
