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
      faster-piper.package = callPackage ./faster-piper.nix {};
      lazygit.package = lazygit;
      zoom.package = zoom;
    };
  };

  xdg.configFile = {
    "yazi/keymap.toml".source = mkOutOfStoreSymlink "keymap.toml";
    "yazi/theme.toml".source = mkOutOfStoreSymlink "theme.toml";
    "yazi/yazi.toml".source = mkOutOfStoreSymlink "yazi.toml";
  };
}
