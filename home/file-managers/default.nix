{ config, pkgs, user, ... }:

with pkgs.unstable;
{
  home.packages = [
    ffmpeg-headless
    fontforge
    poppler-utils
    resvg
    _7zip-zstd
  ];

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    package = yazi;
  };

  xdg.configFile."elio".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/file-managers/elio";

  xdg.configFile."yazi".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/file-managers/yazi";
}
