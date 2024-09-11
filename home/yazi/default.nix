{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.unstable.yazi;
  };

  xdg.configFile."yazi/theme.toml".source  = ./theme.toml;
}
