{ config, pkgs, lib, user, ... }:

{
  home.packages = with pkgs.unstable; [
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
      zshPluginScripts = [
        "${zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
        "${zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
        "${zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh"
        "${zsh-f-sy-h}/share/zsh/site-functions/F-Sy-H.plugin.zsh"
        "${zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
      ];

      zshrc = {
        first = lib.mkOrder 500 ''
        '';

        beforeCompletion = lib.mkOrder 550 ''
          fpath+="${zsh-completions}/share/zsh/site-functions"
          fpath+="${nix-zsh-completions}/share/zsh/site-functions"
          autoload -Uz compinit && compinit

          autoload -Uz ${zsh-defer}/share/zsh-defer/zsh-defer
          ${lib.concatStringsSep "\n" (map (script: "zsh-defer source ${script}") zshPluginScripts)}
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
}
