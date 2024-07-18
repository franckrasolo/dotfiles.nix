{ pkgs, ... }:

{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.unstable.fzf;
  };
}
