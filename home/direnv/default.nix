{ pkgs, ... }:

{
  home.packages = with pkgs; [ direnv ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

# xdg.configFile."direnv/direnvrc".source = ./direnvrc;
}
