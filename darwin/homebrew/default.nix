{ lib, ... }:

let
  cask = name: { name = name; };

  # for casks that must be installed system-wide
  systemApp = cask: lib.recursiveUpdate cask {
    args = { appdir = "/Applications"; };
  };

  # for casks missing a sha256 checksum
  skipVerification = cask: lib.recursiveUpdate cask {
    args = { require_sha = false; };
  };

  webBrowsers = [
    "arc"
    "crest-browser"
    (systemApp (cask "duckduckgo"))
    "opera"
    "zen"
  ];
in
{
  homebrew = {
    enable = true;

    global = {
      autoUpdate = true;
      brewfile = true;
    };

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
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
      (systemApp (cask "1password"))
      "nikitabobko/tap/aerospace"
      "alfred"
      "altersend"
      (skipVerification (cask "amadeus-pro"))
      "arcbox"
      (skipVerification (cask "audio-hijack"))
      "beadbox/cask/beadbox"
      (skipVerification (cask "beeper"))
      "bunch"
      (skipVerification (cask "daisydisk"))
      "deskpad"
      "discord"
      "dropbox"
      "expressvpn"
      "fluidvoice"
      (systemApp (cask "hammerspoon"))
      "jetbrains-toolbox"
      (systemApp (cask "lm-studio"))
      "localsend"
      (skipVerification (cask "logitech-options"))
      (skipVerification (cask "logi-options+"))
      "mac-sai"
      "macshot"
      (systemApp (skipVerification (cask "megacmd-app")))
      (systemApp (skipVerification (cask "megasync")))
      "obsidian"
      "onedrive"
      (systemApp (cask "orbstack"))
      "raindropio"
      "recordly"
      (systemApp (cask "secretive"))
      "snapzy"
      (skipVerification (cask "speechify-voice-ai"))
      (skipVerification (cask "spotify"))
      "tailscale-app"
      "teamviewer"
      "telegram"
      "tuple"
      "vlc"
      "vorssaint"
      "wezterm"
      (systemApp (cask "wispr-flow"))
      (systemApp (cask "zoom"))
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
