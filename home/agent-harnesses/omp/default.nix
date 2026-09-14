{ config, user, ... }:

{
  home.file.".omp/agent".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/agent-harnesses/omp/agent";
}
