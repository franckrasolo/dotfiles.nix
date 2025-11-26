{ config, pkgs, user, ... }:

{
  programs.k9s = {
    enable = true;
    package = pkgs.unstable.k9s;
  };

  xdg.configFile."k9s".source = config.lib.file.mkOutOfStoreSymlink "${user.homeDirectory}/dev/dotfiles.nix/home/k9s";
}
