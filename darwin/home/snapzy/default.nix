{ config, user, ... }:

{
  home.file.".config/snapzy/config.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/darwin/home/snapzy/config.toml";
}
