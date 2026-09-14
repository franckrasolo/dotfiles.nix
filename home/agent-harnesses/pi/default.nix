{ config, user, ... }:

{
  home.file.".pi/agent".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/agent-harnesses/pi/agent";
}
