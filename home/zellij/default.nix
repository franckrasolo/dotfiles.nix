{ pkgs, ... }:

{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.zellij-latest;
  };

  xdg.configFile = {
    "zellij/config.kdl".source = ./config.kdl;
    "zellij/layouts/riced.kdl".text = import ./layouts/riced.kdl.nix { inherit pkgs; };
    "zellij/layouts/riced.swap.kdl".source = ./layouts/riced.swap.kdl;
    "zellij/themes".source = ./themes;
  };

  home.file."Library/Caches/org.Zellij-Contributors.Zellij/permissions.kdl".text = ''
    "${pkgs.zjstatus}/bin/zjstatus.wasm" {
      RunCommands
      ReadApplicationState
      ChangeApplicationState
    }
  '';
}
