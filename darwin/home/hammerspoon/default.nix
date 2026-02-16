{ config, lib, user, ... }:

{
  xdg.configFile."hammerspoon".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/darwin/home/hammerspoon";

  home.activation.configureHammerspoon = with lib; mkForce (hm.dag.entryAfter [ "batCache" ] ''
    # configure Hammerspoon preferences
    defaults write org.hammerspoon.Hammerspoon HSAppleScriptEnabledKey           -bool true
    defaults write org.hammerspoon.Hammerspoon HSAutoLoadExtensions              -bool true
    defaults write org.hammerspoon.Hammerspoon MJConfigFile                      "$XDG_CONFIG_HOME/hammerspoon/init.lua"
    defaults write org.hammerspoon.Hammerspoon HSConsoleDarkModeKey              -bool true
    defaults write org.hammerspoon.Hammerspoon HSPreferencesDarkModeKey          -bool true
    defaults write org.hammerspoon.Hammerspoon MJKeepConsoleOnTopKey             -bool false
    defaults write org.hammerspoon.Hammerspoon MJShowDockIconKey                 -bool false
    defaults write org.hammerspoon.Hammerspoon MJShowMenuIconKey                 -bool true
    defaults write org.hammerspoon.Hammerspoon MJSkipDockMenuIconProblemAlertKey -bool false
    defaults write org.hammerspoon.Hammerspoon SUEnableAutomaticChecks           -bool true
    defaults write org.hammerspoon.Hammerspoon HSUploadCrashData                 -bool true

    # add a login item for Hammerspoon
    osascript -e 'tell application "System Events" to make login item at end with properties { name: "Hammerspoon", path:"/Applications/Hammerspoon.app", hidden:false }'

    # restart Hammerspoon to pick up changes
    # shellcheck disable=SC2015
    killall Hammerspoon && sleep 1 || true
    open -a /Applications/Hammerspoon.app && sleep 1

    hammerspoon_cli="/Applications/Hammerspoon.app/Contents/Frameworks/hs/hs"
    $hammerspoon_cli -c "hs.console.clearConsole()"
    $hammerspoon_cli -c "hs.reload()"
  '');
}
