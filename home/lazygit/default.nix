{ config, pkgs, user, ... }:

{
  programs.lazygit = {
    enable = true;
    package = pkgs.unstable.lazygit;
    settings = {};
  };

  xdg.configFile."lazygit/config.yml".source = config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/lazygit/config.yml";
}
