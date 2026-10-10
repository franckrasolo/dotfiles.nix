{ config, lib, pkgs, ... }:

with pkgs.unstable;
{
  home.packages = [ silicon ];

  home.activation.siliconCache = with lib; mkForce (hm.dag.entryAfter [ "batCache" ] ''
    verboseEcho "Rebuilding the silicon cache using bat syntaxes and themes..."
    cd ${escapeShellArg "${config.xdg.configHome}/bat"}
    run ${lib.getExe silicon} --build-cache
  '');

  xdg.configFile."silicon/config".source = ./config;
}
