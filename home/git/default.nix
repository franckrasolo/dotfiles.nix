{ config, pkgs, user, ... }:

{
  home.packages = with pkgs.unstable; [
    git
    git-crypt
    git-lfs
    git-who
    diff-so-fancy
    ec
  ];

  programs.delta = {
    enable = true;
    package = pkgs.unstable.delta;
  };

  xdg.configFile."git".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/git";
}
