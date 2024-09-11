{ config, pkgs, lib, ... }:

{
  programs.bat = {
    enable = true;
    package = pkgs.unstable.bat;
    config = {
      map-syntax = [
        "*{j,J}ustfile*:Just"
      ];
      pager = "less -FR";
      theme = "Catppuccin Mocha";
    };
    syntaxes = {
      Just = {
        src = pkgs.fetchFromGitHub {
          owner = "nk9";
          repo = "just_sublime";
          rev = "08bbc62e9e77c82fb0fa6cabc0630cb5cc4bcd0e";
          hash = "sha256-wSZe0uklnH3SooFR8RqAeGj3WL3W2cqNeSH/nQS3/4s=";
        };
        file = "Syntax/Just.sublime-syntax";
      };
    };
    themes = {
      "Catppuccin Mocha" = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "d714cc1d358ea51bfc02550dabab693f70cccea0";
          hash = "sha256-Q5B4NDrfCIK3UAMs94vdXnR42k4AXCqZz6sRn8bzmf4=";
        };
        file = "themes/Catppuccin Mocha.tmTheme";
      };
    };
  };

  home.activation.batCache = with lib; mkForce (hm.dag.entryAfter [ "linkGeneration" ] ''
    export XDG_CACHE_HOME=${escapeShellArg config.xdg.cacheHome}
    export XDG_CONFIG_HOME=${escapeShellArg config.xdg.configHome}

    export BAT_CACHE_PATH=$XDG_CACHE_HOME/bat
    export BAT_CONFIG_DIR=$XDG_CONFIG_HOME/bat

    verboseEcho "Rebuilding the bat cache..."
    cd "${pkgs.emptyDirectory}"
    run ${lib.getExe config.programs.bat.package} cache --build
  '');
}
