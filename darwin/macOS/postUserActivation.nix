{
  system.activationScripts.postUserActivation.enable = true;
  system.activationScripts.postUserActivation.text = ''
    # close System Preferences to prevent any overriding of settings that are about to change
    osascript -e 'tell application "System Preferences" to quit'

    # load Bunch automations
    open 'x-bunch://setPref?configDir=~/.xdg/config/bunches'
  '';
}
