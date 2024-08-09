{ config, pkgs, user, ... }:

{
  imports = [
    ./packages.nix
    ./bat
    (import ./direnv { inherit user; })
    ./fzf
    (import ./zsh { inherit config pkgs user; })
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
      "lazygit".source     = mkOutOfStoreSymlink "${user.homeDirectory}/dev/dotfiles.nix/home/lazygit";
      "luarocks".source    = ./luarocks;
      "nvim".source        = mkOutOfStoreSymlink "${user.homeDirectory}/dev/dotfiles.nix/home/nvim";
      "ripgrep".source     = ./ripgrep;
      "wezterm".source     = mkOutOfStoreSymlink "${user.homeDirectory}/dev/dotfiles.nix/home/wezterm";
      "zathura".source     = mkOutOfStoreSymlink "${user.homeDirectory}/dev/dotfiles.nix/home/zathura";
    };
  };

  home = {
    enableNixpkgsReleaseCheck = false;

    sessionVariables = {
      PAGER  = "less -FR";
      EDITOR = "nvim";
      VISUAL = "nvr -cc split --remote-wait +'set bufhidden=wipe'";
      TERM   = "xterm-256color";
    };

    extraOutputsToInstall = [ "man" ];
    stateVersion = "24.05";
  };

  manual.manpages.enable = true;
  programs.man.enable = false; # needed so that host OS man pages remain accessible
  programs.home-manager.enable = true;
}
