{ config, user, ... }:

{
  imports = [
    ./packages.nix
    ./bat
    ./cmux
    ./direnv
    ./fnox
    ./fzf
    ./git
    ./k9s
    ./lazygit
    ./luarocks
    ./mise
    ./nvim
    ./opencode
    ./ov
    ./pdf
    ./presenterm
    ./ripgrep
    ./silicon
    ./television
    ./tmux
    ./wezterm
    ./workmux
    ./yazi
    ./zellij
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
      "duti".source      = ./duti;
      "fastfetch".source = ./fastfetch;
    };
  };

  home = {
    enableNixpkgsReleaseCheck = false;
    extraOutputsToInstall = [ "man" ];
    stateVersion = "25.05";
  };

  manual.manpages.enable = true;
  programs.man.enable = false; # needed so that host OS man pages remain accessible
  programs.home-manager.enable = true;
}
