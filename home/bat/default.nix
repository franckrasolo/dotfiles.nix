{ config, pkgs, lib, ... }:

{
  programs.bat = {
    enable = true;
    package = pkgs.bat;
    config = {
      map-syntax = [
        "*{j,J}ustfile*:Just"
        "*mise*.lock:TOML"
        "*tmux*.conf:Tmux conf"
      ];
      pager = "less -FR";
      theme = "Catppuccin Mocha";
    };
    syntaxes = {
      Just = {
        src = pkgs.fetchFromGitHub {
          owner = "nk9";
          repo = "just_sublime";
          rev = "2dcc60286d1af6a4c6c2c03d50bc03230dc56ce3";
          hash = "sha256-XlxItYVL9I612DhfCGHiUdv6U6Nv9LOlEbJVf1zTwPg=";
        };
        file = "Syntax/Just.sublime-syntax";
      };
      KDL1 = {
        src = pkgs.fetchFromGitHub {
          owner = "eugenesvk";
          repo = "sublime-KDL";
          rev = "06dbd737d9961d141c5c46397a5285c205fb9bf6";
          hash = "sha256-6RH8xAYDkeYtIJL0AcnUyti2DH5P0v6Jv67mkkxySKY=";
        };
        file = "KDL1.sublime-syntax";
      };
      Tmux = {
        src = pkgs.fetchFromGitHub {
          owner = "Edditoria";
          repo = "tmux-sublime";
          rev = "273258e1f80ea1e9f1bbd3d699afbd5196a0caf1";
          hash = "sha256-fG4QgbyBB8mKCbeRq4RuJT9y+I+mg8JZtmJPpETuauU=";
        };
        file = "Tmux.sublime-syntax";
      };
    };
    themes = {
      "Catppuccin Mocha" = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "6810349b28055dce54076712fc05fc68da4b8ec0";
          hash = "sha256-lJapSgRVENTrbmpVyn+UQabC9fpV1G1e+CdlJ090uvg=";
        };
        file = "themes/Catppuccin Mocha.tmTheme";
      };
    };
  };

  home.activation.batCache = with lib; mkForce (hm.dag.entryAfter [ "prepareUserActivation" ] ''
    export XDG_CACHE_HOME=${escapeShellArg config.xdg.cacheHome}
    export XDG_CONFIG_HOME=${escapeShellArg config.xdg.configHome}

    export BAT_CACHE_PATH=$XDG_CACHE_HOME/bat
    export BAT_CONFIG_DIR=$XDG_CONFIG_HOME/bat

    verboseEcho "Rebuilding the bat cache..."
    cd "${pkgs.emptyDirectory}"
    run ${lib.getExe config.programs.bat.package} cache --build
  '');
}
