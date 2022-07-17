{
  system.defaults.trackpad = {
    Clicking = true;
    TrackpadRightClick = true;
    TrackpadThreeFingerDrag = true;
  };

  system.defaults.NSGlobalDomain = {
    "com.apple.trackpad.enableSecondaryClick" = true;
#   "com.apple.trackpad.forceClick" = false;

    # trackpad tracking speed
    "com.apple.trackpad.scaling" = "1.75";

    # enable right-click (mode 1)
    "com.apple.trackpad.trackpadCornerClickBehavior" = 1;
  };
}
