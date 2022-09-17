{ user, ... }:

{
  system.defaults.NSGlobalDomain = {
    # automatically hide and show the menu bar
    _HIHideMenuBar = true;

    # use a dark menu bar and Dock
    AppleInterfaceStyle = "Dark";

    # enable subpixel font rendering on non-Apple LCDs
    # see https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
    AppleFontSmoothing  = 1;
    AppleShowScrollBars = "WhenScrolling";

    AppleMeasurementUnits = "Centimeters";
    AppleMetricUnits      = 1;
    AppleTemperatureUnit  = "Celsius";

    # disable automatic typography options
    NSAutomaticCapitalizationEnabled     = false;
    NSAutomaticDashSubstitutionEnabled   = false;
    NSAutomaticPeriodSubstitutionEnabled = false;
    NSAutomaticQuoteSubstitutionEnabled  = false;
    NSAutomaticSpellingCorrectionEnabled = false;

    # expand the save panel by default
    NSNavPanelExpandedStateForSaveMode   = true;
    NSNavPanelExpandedStateForSaveMode2  = true;

#   NSCloseAlwaysConfirmsChanges  = true;
    NSDisableAutomaticTermination = true;
    NSDocumentSaveNewDocumentsToCloud = true;
#   NSQuitAlwaysKeepsWindows = true;
#   NSSpellCheckerAutomaticallyIdentifiesLanguages = true;
    NSTableViewDefaultSizeMode   = 2;
    NSTextShowsControlCharacters = true;
    NSAutomaticWindowAnimationsEnabled = false;
    NSUseAnimatedFocusRing   = false;
    NSScrollAnimationEnabled = true;
    NSWindowResizeTime = 0.001;
#   WebKitDeveloperExtras = true;

    # always expand the print panel
    PMPrintingExpandedStateForPrint = true;
    PMPrintingExpandedStateForPrint2 = true;

    # enable tap-to-click (mode 1)
    "com.apple.mouse.tapBehavior" = 1;

    # enable spring loading (expose) for directories
    "com.apple.springing.enabled" = true;

    "com.apple.springing.delay" = 0.0;
    "com.apple.swipescrolldirection" = true;
  };

  system.defaults.LaunchServices = {
    # disable the "Are you sure you want to open this application?" dialog
    LSQuarantine = false;
  };

  system.defaults.screencapture = {
    location = "${user.homeDirectory}/Downloads";
    disable-shadow = true;
  };

  system.defaults.SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;

  # disable transparency in menus and windows
#  system.defaults.universalaccess.reduceTransparency = false;
}
