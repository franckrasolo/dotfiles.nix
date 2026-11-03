{ config, user, ... }:

{
  xdg.configFile."formae".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/infra/formae";
}
