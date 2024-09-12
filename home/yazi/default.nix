{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.unstable.yazi;
  };

  xdg.configFile."yazi/yazi.toml".source  = ./yazi.toml;
  xdg.configFile."yazi/theme.toml".source = ./theme.toml;
}
