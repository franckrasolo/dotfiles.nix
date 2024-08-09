{ config, pkgs, user, ... }:

{
  home.packages = with pkgs.unstable; [
    antibody
    powerline-go
    vivid
  ];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    package = pkgs.unstable.zsh;
  };

  programs.command-not-found.enable = true;

#  xdg.configFile."zsh".source = ./.;
  xdg.configFile."zsh".source = config.lib.file.mkOutOfStoreSymlink "${user.homeDirectory}/dev/dotfiles.nix/home/zsh";

#  home.file.".zshenv".source = ./zsh/zshenv;
  home.file.".zshenv".source = config.lib.file.mkOutOfStoreSymlink "${user.homeDirectory}/dev/dotfiles.nix/home/zsh/zshenv";
}
