{ pkgs, ... }:

{
  programs.lazygit = {
    enable = true;
    package = pkgs.unstable.lazygit;
    settings = {};
  };

  xdg.configFile."lazygit/config.yml".source = ./config.yml;
}
