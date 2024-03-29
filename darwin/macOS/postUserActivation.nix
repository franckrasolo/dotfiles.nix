{ pkgs, ... }:

{
  system.activationScripts.postUserActivation.enable = true;
  system.activationScripts.postUserActivation.text = with pkgs.unstable; ''
    launchctl setenv XDG_CACHE_HOME   ~/.xdg/cache
    launchctl setenv XDG_CONFIG_HOME  ~/.xdg/config
    launchctl setenv XDG_DATA_HOME    ~/.xdg/local/share
    launchctl setenv XDG_STATE_HOME   ~/.xdg/local/state
    launchctl setenv GRADLE_USER_HOME ~/.xdg/local/share/gradle
    launchctl setenv DOCKER_CONFIG    ~/.xdg/config/docker
    launchctl setenv KUBECONFIG       ~/.xdg/config/kube

    # 1Password integration requires the CLI binary at a specific location
    sudo ${coreutils}/bin/cp ${_1password}/bin/op /usr/local/bin/op

    # close System Preferences to prevent any overriding of settings that are about to change
    osascript -e 'tell application "System Preferences" to quit'

    # apply different wallpapers to each desktop
    open 'x-bunch://setPref?configDir=~/.xdg/config/bunches'

    defaults write NSGlobalDomain AppleLanguages -array "en"
    defaults write NSGlobalDomain AppleLocale -string "en_GB@currency=GBP"

    # use a dark menu bar and Dock
    osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to True'

    # enable subpixel anti-aliasing (font smoothing)
    # https://dev.to/mrahmadawais/onedevminute-fixing-terrible-blurry-font-rendering-issue-in-macos-mojave--lck
    defaults write NSGlobalDomain CGFontRenderingFontSmoothingDisabled -bool false

    # disable transparency in the menu bar
    defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false

    # set default handlers for Apple UTIs, URL schemes, file extensions, and MIME types
#   duti $XDG_CONFIG_HOME/duti/   # must run *after* home-manager
    duti ~/dev/dotfiles.nix/home/duti/

    # apply changes immediately
    killall Dock
    killall SystemUIServer
  '';
}
