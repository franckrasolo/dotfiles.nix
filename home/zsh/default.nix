{ config, pkgs, lib, user, ... }:

{
  home.packages = with pkgs.unstable; [
    antibody
    powerline-go
    vivid
  ];

  programs.zsh = {
    enable = true;
    package = pkgs.unstable.zsh;
    dotDir = "${config.xdg.configHome}/zsh";
    autosuggestion.enable = true;
    enableCompletion = true;
    envExtra = ''
      source ~/.zshenv.manual
    '';

    initContent = with pkgs; let
      zshrc = {
        first = lib.mkOrder 500 ''
        '';

        beforeCompletion = lib.mkOrder 550 ''
        '';

        general = lib.mkOrder 1000 ''
          source $ZDOTDIR/zshrc
        '';

        last = lib.mkOrder 1500 ''
        '';
      };
    in
      lib.mkMerge [
        zshrc.first
        zshrc.beforeCompletion
        zshrc.general
        zshrc.last
      ];
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
