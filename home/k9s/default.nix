{ config, pkgs, user, ... }:

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

  xdg.configFile."k9s".source = config.lib.file.mkOutOfStoreSymlink "${user.homeDirectory}/dev/dotfiles.nix/home/k9s";
}
