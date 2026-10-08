{ config, pkgs, user, ... }:

let
  mkOutOfStoreSymlink = file:
    config.lib.file.mkOutOfStoreSymlink
      "${user.dotfiles}/home/file-managers/yazi/${file}";
in
{
  programs.yazi = with pkgs.unstable; {
    enable = true;
    enableZshIntegration = true;
    package = yazi;
    plugins = with yaziPlugins; {
      lazygit.package = lazygit;
      piper.package = piper;
      zoom.package = zoom;
    };
  };

  xdg.configFile = {
    "yazi/keymap.toml".source = mkOutOfStoreSymlink "keymap.toml";
    "yazi/theme.toml".source = mkOutOfStoreSymlink "theme.toml";
    "yazi/yazi.toml".source = mkOutOfStoreSymlink "yazi.toml";
  };
}
