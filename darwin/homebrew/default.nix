let
  # for casks that must be installed system-wide
  systemApp = cask: {
    name = cask;
    args = {
      appdir = "/Applications";
    };
  };

  # for casks missing a sha256 checksum
  skipVerification = cask: {
    name = cask;
    args = {
      require_sha = false;
    };
  };

  webBrowsers = [
    "arc"
    "crest-browser"
    (systemApp "duckduckgo")
    "opera"
    "zen"
  ];
in
{
  homebrew = {
    enable     = true;

    global = {
      autoUpdate = true;
      brewfile   = true;
    };

    onActivation = {
      autoUpdate = true;
      upgrade    = true;
      cleanup    = "zap";
    };

    taps = map (tap: { name = tap; trusted = true; }) [
      "martido/homebrew-graph"
    ];

    brews = [
      "elio"
      "headson"
      "taproom"
    ];

    casks = [
      # 1Password warns that it will neither fill nor save logins
      # in browsers when it isn't installed under /Applications
      (systemApp "1password")
      "nikitabobko/tap/aerospace"
      "alfred"
      "altersend"
      (skipVerification "amadeus-pro")
      "arcbox"
      (skipVerification "audio-hijack")
      "beadbox/cask/beadbox"
      (skipVerification "beeper")
      "bunch"
      (skipVerification "daisydisk")
      "deskpad"
      "discord"
      "dropbox"
      "expressvpn"
      "fluidvoice"
      (systemApp "hammerspoon")
      "jetbrains-toolbox"
      (systemApp "lm-studio")
      "localsend"
      (skipVerification "logitech-options")
      (skipVerification "logi-options+")
      "mac-sai"
      "macshot"
      {
        name = "megacmd-app";
        args = {
          appdir = "/Applications";
          require_sha = false; # missing sha256 checksum
        };
      }
      {
        name = "megasync";
        args = {
          appdir = "/Applications";
          require_sha = false; # missing sha256 checksum
        };
      }
      "obsidian"
      "onedrive"
      (systemApp "orbstack")
      "raindropio"
      "recordly"
      (systemApp "secretive")
      "snapzy"
      (skipVerification "speechify-voice-ai")
      (skipVerification "spotify")
      "tailscale-app"
      "teamviewer"
      "telegram"
      "tuple"
      "vlc"
      "vorssaint"
      "wezterm"
      (systemApp "wispr-flow")
      (systemApp "zoom")
    ] ++ webBrowsers;

    caskArgs = {
      appdir = "~/Applications/Homebrew Apps";
      require_sha = true;
    };

    masApps = {
      # macOS default apps
      GarageBand = 682658836;
      iMovie = 408981434;
      Keynote = 361285480;
      Numbers = 361304891;
      Pages = 361309726;

      # additional apps
      DeskBoard2 = 6758047889;
      Gapplin = 768053424;
      Gifski = 1351639930;
      "Jamf Trust" = 1608041266;
      Xcode = 497799835;
    };
  };
}
