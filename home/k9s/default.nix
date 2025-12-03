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

  xdg.configFile."k9s".source = mkOutOfStoreSymlink "${user.homeDirectory}/dev/dotfiles.nix/home/k9s";

  xdg.dataFile."k9s/clusters".source = mkOutOfStoreSymlink "${user.homeDirectory}/dev/dotfiles.nix/home/k9s/clusters";
}
