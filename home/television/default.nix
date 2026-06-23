{ config, pkgs, user, ... } @ args:

with pkgs.unstable;
{
  programs.television = {
    enable = true;
    enableZshIntegration = true;
    package = television;
  };

  programs.nix-search-tv = {
    enable = true;
    enableTelevisionIntegration = false;
    package = nix-search-tv;

    settings = {
      indexes = [ "darwin" "nixpkgs" "nur" "nixos" ];

      experimental = {
        render_docs_indexes = {
          home-manager-stable = "https://home-manager.dev/manual/26.05/options.xhtml";
        };
        options_file = with args; {
          sops-nix = sops-nix-options;
          nixos-lima = nixos-lima-options;
        };
      };

      enable_waiting_message = true;
      update_interval = "72h";
    };
  };

  xdg.configFile."television".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/television";

  home.file.".xdg/local/bin/tv-sesh-connect".source = ./bin/tv-sesh-connect.zsh;
}
