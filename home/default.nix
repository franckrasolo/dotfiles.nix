{ config, user, ... }:

{
  imports = [
    ./packages.nix
    ./bat
    ./cmux
    ./direnv
    ./fnox
    ./fzf
    ./k9s
    ./lazygit
    ./luarocks
    ./mise
    ./nvim
    ./presenterm
    ./ripgrep
    ./silicon
    ./wezterm
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

    configFile = with config.lib.file; {
      "1Password".source   = ./1Password;
      "duti".source        = ./duti;
      "fastfetch".source   = ./fastfetch;
      "git".source         = mkOutOfStoreSymlink "${user.dotfiles}/home/git";
      "zathura".source     = mkOutOfStoreSymlink "${user.dotfiles}/home/zathura";
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
