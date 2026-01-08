{ config, pkgs, lib, user, ... }:

{
  home.packages = with pkgs.unstable; [
    antibody
    powerline-go
    vivid
  ];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    package = pkgs.zsh;
    envExtra = ''
      source ~/.zshenv.manual
    '';
  };

  programs.command-not-found.enable = true;

#  xdg.configFile."zsh".source = ./.;
  xdg.configFile."zsh".source = config.lib.file.mkOutOfStoreSymlink "${user.homeDirectory}/dev/dotfiles.nix/home/zsh";

#  home.file.".zshenv.manual".source = ./zsh/zshenv;
  home.file.".zshenv.manual".source = config.lib.file.mkOutOfStoreSymlink "${user.homeDirectory}/dev/dotfiles.nix/home/zsh/zshenv";

  home.activation.zshPluginsUpdate = with lib; mkForce (hm.dag.entryAfter [ "batCache" ] ''
    export ANTIBODY_HOME="${escapeShellArg config.xdg.cacheHome}/antibody"
    export PATH="${pkgs.unstable.git}/bin:$PATH"
    export ZDOTDIR="${escapeShellArg config.xdg.configHome}/zsh"

    verboseEcho "Updating zsh plugins..."
    run ${lib.getExe pkgs.unstable.antibody} bundle < $ZDOTDIR/plugins.txt >| $ZDOTDIR/plugins.zsh
  '');
}
