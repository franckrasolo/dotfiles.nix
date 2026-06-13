{ config, pkgs, user, ... }:

{
  home.packages = with pkgs.unstable; [
    lazygit
  ];

  xdg.configFile."lazygit/config.yml".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/lazygit/config.yml";
}
