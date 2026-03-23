{ config, pkgs, user, ... }:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.unstable.yazi;
  };

  xdg.configFile."yazi".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/yazi";
}
