{ pkgs, ... }:

{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.unstable.zellij;
  };
}
