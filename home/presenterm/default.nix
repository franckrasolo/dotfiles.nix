{ pkgs, ... }:

let
  highlighting = rec {
    name = "Catppuccin Mocha";
    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "bat";
      rev = "d714cc1d358ea51bfc02550dabab693f70cccea0";
      hash = "sha256-Q5B4NDrfCIK3UAMs94vdXnR42k4AXCqZz6sRn8bzmf4=";
    };
    file = "themes/${name}.tmTheme";
  };
in {
  home.packages = [ pkgs.presenterm-with-sixel ];

  xdg.configFile."presenterm/config.yaml".source = ./config.yaml;
  xdg.configFile."presenterm/themes/catppuccin-dark.yaml".source = ./themes/catppuccin-dark.yaml;
  xdg.configFile."presenterm/themes/highlighting/${highlighting.name}.tmTheme".source =
    "${highlighting.src}/${highlighting.file}";
}
