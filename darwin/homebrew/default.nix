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

    taps = [
      "homebrew/bundle"
      "homebrew/cask-versions"
      "martido/homebrew-graph"
      "opslevel/tap"
      "snyk/tap"
    ];

    brews = [
      "opslevel/tap/cli"
      "snyk"
    ];

    casks = [
      {
        # 1Password warns that it will neither fill nor save logins
        # in browsers when it isn't installed under /Applications
        name = "1password";
        args = { appdir = "/Applications"; };
      }
      "alfred"
      "alacritty"
      {
        name = "amadeus-pro";
        args = { require_sha = false; }; # missing sha256 checksum
      }
      {
        name = "audio-hijack";
        args = { require_sha = false; }; # missing sha256 checksum
      }
      "bunch"
      "cloudflare-warp"
      "daisydisk"
      "discord"
      "docker"
      "dropbox"
      "expressvpn"
      "jetbrains-toolbox"
      "keycastr"
      "kitty"
      {
        name = "logitech-options";
        args = { require_sha = false; }; # missing sha256 checksum
      }
      {
        name = "logi-options-plus";
        args = { require_sha = false; }; # missing sha256 checksum
      }
      "megasync"
      "obsidian"
      "pop"
      {
        name = "secretive";
        args = { appdir = "/Applications"; };
      }
      "sonos-s1-controller"
      "spotify"
      "teamviewer"
      "temurin17"
      "temurin21"
      "tuple"
      "tweeten"
      "vlc"
      "wavebox"
      "wezterm"
      {
        # Zoom must also be installed under /Applications
        name = "zoom";
        args = { appdir = "/Applications"; };
      }
    ];

    caskArgs = {
      appdir = "~/Library/Homebrew/Applications";
      no_quarantine = true;
      require_sha = true;
    };
  };
}
