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

  xdg.configFile."git".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/git";
}
