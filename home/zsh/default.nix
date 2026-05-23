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
    enableCompletion = false;
    envExtra = ''
      source ~/.zshenv.manual
    '';

    initContent = with pkgs.unstable; let
      zshPluginScripts = [
        "${zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh"
        "${zsh-f-sy-h}/share/zsh/site-functions/F-Sy-H.plugin.zsh"
        "${zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
      ];

      zshrc = {
        first = lib.mkOrder 500 ''
          profiling=false && zmodload zsh/zprof || true # https://getantibody.github.io/even-faster/
        '';

        beforeCompletion = lib.mkOrder 550 ''
          fpath+=(
            "${zsh-completions}/share/zsh/site-functions"
            "${nix-zsh-completions}/share/zsh/site-functions"
          )

          autoload -Uz ${zsh-defer}/share/zsh-defer/zsh-defer
          ${lib.concatStringsSep "\n" (map (script: "zsh-defer source ${script}") zshPluginScripts)}

          # zsh-defer -c 'eval "$(zsh-patina activate)"'
        '';

        general = lib.mkOrder 1000 ''
          source $ZDOTDIR/zshrc
        '';

        last = lib.mkOrder 1500 ''
          $profiling && zprof || true
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
  xdg.configFile."zsh".source = config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/zsh";

  xdg.configFile."zsh-patina/config.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/zsh/zsh-patina.toml";

  # suppress both "Last login" and MOTD messages in new shells
  home.file.".hushlogin".text = "";

#  home.file.".zshenv.manual".source = ./zsh/zshenv;
  home.file.".zshenv.manual".source = config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/zsh/zshenv";
}
