{ config, user, ... }:

{
  imports = [
    ./packages.nix
    ./bat
    ./direnv
    ./fzf
    ./lazygit
    ./nvim
    ./presenterm
    ./ripgrep
    ./silicon
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

    configFile = with config.lib.file; {
      "1Password".source   = ./1Password;
      "duti".source        = ./duti;
      "fastfetch".source   = ./fastfetch;
      "git".source         = mkOutOfStoreSymlink "${user.homeDirectory}/dev/dotfiles.nix/home/git";
      "luarocks".source    = ./luarocks;
      "wezterm".source     = mkOutOfStoreSymlink "${user.homeDirectory}/dev/dotfiles.nix/home/wezterm";
      "zathura".source     = mkOutOfStoreSymlink "${user.homeDirectory}/dev/dotfiles.nix/home/zathura";
    };
  };

  home = {
    enableNixpkgsReleaseCheck = false;
    extraOutputsToInstall = [ "man" ];
    stateVersion = "24.05";
  };

  manual.manpages.enable = true;
  programs.man.enable = false; # needed so that host OS man pages remain accessible
  programs.home-manager.enable = true;
}
