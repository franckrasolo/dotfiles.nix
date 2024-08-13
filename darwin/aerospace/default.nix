{ config, user, pkgs, lib, ... }:
#{ user, ... }:

{
  home-manager.users.${user.accountName} = pkgs.lib.mkMerge [
    ({ config, ... }: with config.lib.file; {
      xdg.configFile."aerospace".source = mkOutOfStoreSymlink "${user.homeDirectory}/dev/dotfiles.nix/darwin/aerospace";
    })
  ];
#  home-manager.users.${user.accountName}.xdg.configFile."aerospace".source = ./.;
}
