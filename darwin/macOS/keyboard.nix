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
}
