{ config, user, ... }:

{
  home.file.".omp/agent".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/omp/agent";
}
