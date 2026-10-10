{ lib, user, ... }:

{
  imports = [
    ./agent-harnesses
    ./file-managers
    ./multiplexers
    ./pagers
    ./terminals

    ./packages.nix
    ./direnv
    ./fastfetch
    ./fnox
    ./fzf
    ./git
    ./k9s
    ./lazygit
    ./leaf
    ./luarocks
    ./mise
    ./nvim
    ./pdf
    ./presenterm
    ./ripgrep
    ./silicon
    ./skill-scanner
    ./television
    ./tree-sitter
    ./zoxide
    ./zsh
  ];

  xdg = {
    enable = true;

    cacheHome  = "${user.homeDirectory}/.xdg/cache";
    configHome = "${user.homeDirectory}/.xdg/config";
    dataHome   = "${user.homeDirectory}/.xdg/local/share";
    stateHome  = "${user.homeDirectory}/.xdg/local/state";

    configFile = {
      "1Password".source = ./1Password;
    };
  };

  home = {
    enableNixpkgsReleaseCheck = false;
    extraOutputsToInstall = [ "man" ];
    sessionVariables = {
      XDG_BIN_HOME = lib.mkForce "${user.homeDirectory}/.xdg/local/bin";
    };
    stateVersion = "26.05";
  };

  manual.manpages.enable = true;
  programs.man.enable = false; # needed so that host OS man pages remain accessible
  programs.home-manager.enable = true;
}
