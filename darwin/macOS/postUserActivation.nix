{
  system.activationScripts.postUserActivation.enable = true;
  system.activationScripts.postUserActivation.text = ''
    # close System Preferences to prevent any overriding of settings that are about to change
    osascript -e 'tell application "System Preferences" to quit'

    # load Bunch automations
    open 'x-bunch://setPref?configDir=~/.xdg/config/bunches'

    defaults write NSGlobalDomain AppleLanguages -array "en"
    defaults write NSGlobalDomain AppleLocale -string "en_GB@currency=GBP"

    # enable subpixel anti-aliasing (font smoothing)
    # https://dev.to/mrahmadawais/onedevminute-fixing-terrible-blurry-font-rendering-issue-in-macos-mojave--lck
    defaults write NSGlobalDomain CGFontRenderingFontSmoothingDisabled -bool false

    # disable transparency in the menu bar
    defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false

    # apply changes immediately
    killall Dock
    killall SystemUIServer
  '';
}
