{ config, pkgs, user, ... }:

{
  home.packages = with pkgs.unstable; [
    ffmpeg-headless
    fontforge
    poppler-utils
    resvg
    _7zip-zstd
  ];

  xdg.configFile."elio".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/file-managers/elio";
}
