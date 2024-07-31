{ config, user, pkgs, lib, ... }:

{
  homebrew.casks = [
    {
      name = "hammerspoon";
      args = { appdir = "/Applications"; };
    }
  ];

  home-manager.users.${user.accountName} = pkgs.lib.mkMerge [
    ({ config, ... }: with config.lib.file; {
      xdg.configFile."hammerspoon".source = mkOutOfStoreSymlink "${user.homeDirectory}/dev/dotfiles.nix/darwin/hammerspoon";
    })
    {
      home.activation.reloadHammerspoon =
        config.home-manager.users.${user.accountName}.lib.dag.entryAfter [ "writeBoundary" ] ''
          hammerspoon_cli="/Applications/Hammerspoon.app/Contents/Frameworks/hs/hs"
          $DRY_RUN_CMD $hammerspoon_cli -c "hs.reload()"
          $DRY_RUN_CMD sleep 1
          $DRY_RUN_CMD $hammerspoon_cli -c "hs.console.clearConsole()"
        '';
    }
  ];

  system.activationScripts.postUserActivation.text =
    let
      rocks = [
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
    killall Hammerspoon || true
    open -a /Applications/Hammerspoon.app
  '';
}
