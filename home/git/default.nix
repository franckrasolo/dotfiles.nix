{ config, pkgs, user, ... }:

{
  home.packages = with pkgs.unstable; [
    git
    git-crypt
    git-lfs
    git-who
    diff-so-fancy
    diffnav
    ec
  ];

  programs.delta = {
    enable = true;
    package = pkgs.unstable.delta;
  };

  xdg.configFile."diffnav/config.yml".source = ./diffnav.yaml;

  xdg.configFile."git".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/git";
}
