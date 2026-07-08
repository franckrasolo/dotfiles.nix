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
    gitu
  ];

  programs.delta = {
    enable = true;
    package = pkgs.unstable.delta;
  };

  xdg.configFile."diffnav/config.yml".source = ./diffnav.yaml;

  xdg.configFile."git/allowed_signers".source = ./allowed_signers;

  xdg.configFile."git/config".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/git/config";

  xdg.configFile."gitu/config.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/git/gitu.toml";
}
