{ pkgs, ... }:

{
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.unstable.zoxide;
#    options = [ "--cmd cd" ];
  };
}
