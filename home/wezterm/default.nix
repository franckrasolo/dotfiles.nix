{ config, user, ... }:

{
  xdg.configFile."wezterm".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/wezterm";
}
