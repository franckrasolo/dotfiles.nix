{ config, user, ... }:

{
  xdg.configFile."aerospace".source =
    config.lib.file.mkOutOfStoreSymlink "${user.homeDirectory}/dev/dotfiles.nix/darwin/home/aerospace";
}
