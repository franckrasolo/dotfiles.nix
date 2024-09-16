{ config, lib, pkgs, user, ... }:

{
  home-manager.users.${user.accountName} = pkgs.lib.mkMerge [
    ({ config, ... }: {
      xdg.configFile."hammerspoon".source =
        config.lib.file.mkOutOfStoreSymlink "${user.homeDirectory}/dev/dotfiles.nix/darwin/hammerspoon";
    })
    {
      home.activation.reloadHammerspoon =
        config.home-manager.users.${user.accountName}.lib.dag.entryAfter [ "writeBoundary" ] ''
          hammerspoon_cli="/Applications/Hammerspoon.app/Contents/Frameworks/hs/hs"
          $hammerspoon_cli -c "hs.console.clearConsole()"
          $hammerspoon_cli -c "hs.reload()"
        '';
    }
  ];

  system.activationScripts.postUserActivation.text =
    let
      rocks = [
        "fun"
        "moonscript"
      ];
      installRockCommand = rock: "/etc/profiles/per-user/${user.accountName}/bin/luarocks --local install ${rock}";
    in ''
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

    # install LuaRocks dependencies
    ${lib.concatStringsSep "\n" (map installRockCommand rocks)}

    # restart Hammerspoon to pick up changes
    killall Hammerspoon && sleep 1 || true
    open -a /Applications/Hammerspoon.app
  '';
}
