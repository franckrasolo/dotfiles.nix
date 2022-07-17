{
  system.defaults.NSGlobalDomain = {
    "com.apple.sound.beep.volume"   = "0.6065307";
    "com.apple.sound.beep.feedback" = 0;

    # disable flash with system beep
#   "com.apple.sound.beep.flash" = false;
  };

  system.defaults.".GlobalPreferences" = {
    "com.apple.sound.beep.sound" = "/System/Library/Sounds/Bottle.aiff";
  };
}
