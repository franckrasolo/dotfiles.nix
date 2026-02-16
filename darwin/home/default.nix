{ config, lib, pkgs, user, ... }:

{
  imports = [
    ./aerospace
    ./hammerspoon
  ];

  targets.darwin = {
    copyApps.enable = false;
    linkApps.enable = false;
  };

  xdg.configFile."bunches".source = ./bunches;

  home.activation.prepareUserActivation = with pkgs.unstable; with lib;
    mkForce (hm.dag.entryAfter [ "linkGeneration" ] ''
      export PATH=/usr/bin:/bin:$PATH                 # for macOS open and launchctl
      export PATH=${coreutils}/bin:$PATH              # for cp and readlink used by home-manager
      export PATH=${user.dotfiles}/darwin/bin:$PATH   # for the Homebrew/sudo workaround

      launchctl setenv XDG_CACHE_HOME   ${user.homeDirectory}/.xdg/cache
      launchctl setenv XDG_CONFIG_HOME  ${user.homeDirectory}/.xdg/config
      launchctl setenv XDG_DATA_HOME    ${user.homeDirectory}/.xdg/local/share
      launchctl setenv XDG_STATE_HOME   ${user.homeDirectory}/.xdg/local/state
      launchctl setenv GRADLE_USER_HOME ${user.homeDirectory}/.xdg/local/share/gradle
      launchctl setenv DOCKER_CONFIG    ${user.homeDirectory}/.xdg/config/docker
      launchctl setenv KUBECONFIG       ${user.homeDirectory}/.xdg/config/kube

      # 1Password integration requires the CLI binary at a specific location
      sudo cp ${_1password-cli}/bin/op /usr/local/bin/op

      # set default handlers for Apple UTIs, URL schemes, file extensions, and MIME types
      ${duti}/bin/duti ${user.homeDirectory}/.xdg/config/duti/

      # load Bunch automations – https://bunchapp.co/
      open 'x-bunch://setPref?configDir=~/.xdg/config/bunches'
    '');
}
