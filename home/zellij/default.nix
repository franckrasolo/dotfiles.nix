{ pkgs, ... }:

{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.zellij-latest;
  };
}
