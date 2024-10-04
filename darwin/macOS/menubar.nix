{ user, ... }:

{
  system.defaults.CustomUserPreferences."~/Library/Preferences/ByHost/com.apple.controlcenter.plist" = {
    "AirDrop"          = 8;
    "AudioVideoModule" = 8;
    "BentoBox"         = 8;
    "Bluetooth"        = 8;
    "Display"          = 9;
    "DoNotDisturb"     = 8;
    "FocusModes"       = 8;
    "MusicRecognition" = 9;
    "NowPlaying"       = 8;
    "Shortcuts"        = 8;
    "StateManager"     = 8;
    "Sound"            = 8;
    "WiFi"             = 8;
  };

  system.defaults.CustomUserPreferences."~/Library/Preferences/ByHost/com.apple.Spotlight.plist" = {
    "MenuItemHidden" = true;
  };

  system.defaults.menuExtraClock = {
    IsAnalog   = false;
    Show24Hour = true;
    ShowAMPM   = false;
    ShowDate   = 1;
    ShowDayOfMonth = true;
    ShowDayOfWeek  = true;
    ShowSeconds    = true;
  };

  home-manager.users.${user.accountName}.targets.darwin.defaults."com.apple.menuextra.clock" = {
    FlashDateSeparators = true;
  };
}
