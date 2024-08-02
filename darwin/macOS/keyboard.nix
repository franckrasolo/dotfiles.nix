{ lib, ... }:

{
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = false;
    remapCapsLockToEscape  = false;
  };

  system.defaults.NSGlobalDomain = {
    # disable press-and-hold for keys in favor of key repeat
    ApplePressAndHoldEnabled = false;

    # set a fast though still usable key repeat rate
    InitialKeyRepeat = 12;
    KeyRepeat = 1;

    # enable full keyboard access for all controls (e.g. enable TAB in modal dialogs)
    AppleKeyboardUIMode = 3;

#   "com.apple.keyboard.fnState" = false;
  };

  system.activationScripts.extraUserActivation.text = let
    hotkeys = [
      32 # Mission Control
      34
      33 # Application windows
      35
      79 # Move left a space
      80
      81 # Move right a space
      82
    ];

    disableHotKeyCommands = map (key:
      "defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add ${toString key} '
<dict>
  <key>enabled</key><false/>
  <key>value</key>
  <dict>
    <key>type</key><string>standard</string>
    <key>parameters</key>
    <array>
      <integer>65535</integer>
      <integer>65535</integer>
      <integer>0</integer>
    </array>
  </dict>
</dict>'") hotkeys;

    terminalServices = [
      "com.apple.Terminal - Open man Page in Terminal - openManPage"
      "com.apple.Terminal - Search man Page Index in Terminal - searchManPages"
    ];

    # credit: https://apple.stackexchange.com/a/454359
    disableTerminalServicesCommands = map (key:
      "defaults write pbs NSServicesStatus -dict-add '${key}' '
<dict>
  <key>enabled_context_menu</key><false/>
  <key>enabled_services_menu</key><false/>
  <key>presentation_modes</key>
  <dict>
    <key>ContextMenu</key><false/>
    <key>ServicesMenu</key><false/>
  </dict>
</dict>'") terminalServices;
  in ''
    echo >&2 "configuring hotkeys..."

    ${lib.concatStringsSep "\n" disableHotKeyCommands}

    # credit: https://zameermanji.com/blog/2021/6/8/applying-com-apple-symbolichotkeys-changes-instantaneously/
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

    echo >&2 "disabling Terminal services..."

    ${lib.concatStringsSep "\n" disableTerminalServicesCommands}
  '';
}
