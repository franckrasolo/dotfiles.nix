{ config, pkgs, user, ... }:

with pkgs.unstable;
{
  imports = [
    ./yazi
  ];

  home.packages = [
    ffmpeg-headless
    fontforge
    poppler-utils
    resvg
    _7zip-zstd
  ];

  xdg.configFile."elio".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/file-managers/elio";
}
