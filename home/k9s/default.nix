{ config, pkgs, user, ... }:

with config.lib.file;
with pkgs.unstable;
{
  home.packages = [
    dive
    gonzo
    popeye
  ];

  programs.k9s = {
    enable = true;
    package = k9s;
  };

  xdg.configFile = {
    "k9s/aliases.yaml".source = mkOutOfStoreSymlink "${user.homeDirectory}/dev/dotfiles.nix/home/k9s/aliases.yaml";
    "k9s/config.yaml".source  = mkOutOfStoreSymlink "${user.homeDirectory}/dev/dotfiles.nix/home/k9s/config.yaml";
    "k9s/hotkeys.yaml".source = mkOutOfStoreSymlink "${user.homeDirectory}/dev/dotfiles.nix/home/k9s/hotkeys.yaml";
    "k9s/plugins".source      = mkOutOfStoreSymlink "${user.homeDirectory}/dev/dotfiles.nix/home/k9s/plugins";
    "k9s/skins".source        = mkOutOfStoreSymlink "${user.homeDirectory}/dev/dotfiles.nix/home/k9s/skins";
    "k9s/spinach.yaml".source = mkOutOfStoreSymlink "${user.homeDirectory}/dev/dotfiles.nix/home/k9s/spinach.yaml";
    "k9s/views.yaml".source   = mkOutOfStoreSymlink "${user.homeDirectory}/dev/dotfiles.nix/home/k9s/views.yaml";
  };

  xdg.dataFile = {
    "k9s/clusters".source = mkOutOfStoreSymlink "${user.homeDirectory}/dev/dotfiles.nix/home/k9s/clusters";
  };
}
