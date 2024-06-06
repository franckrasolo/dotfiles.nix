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
      "martido/homebrew-graph"
      "modularml/packages"
    ];

    brews = [
      "modular"
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
      "arc"
      {
        name = "audio-hijack";
        args = { require_sha = false; }; # missing sha256 checksum
      }
      {
        name = "beeper";
        args = { require_sha = false; }; # missing sha256 checksum
      }
      "bunch"
      {
        name = "cloudflare-warp";
        args = { require_sha = false; }; # missing sha256 checksum
      }
      {
        name = "daisydisk";
        args = { require_sha = false; }; # missing sha256 checksum
      }
      "discord"
      {
        name = "docker";
        args = { appdir = "/Applications"; };
      }
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
      {
        name = "megasync";
        args = {
          appdir = "/Applications";
          require_sha = false; # missing sha256 checksum
        };
      }
      "obsidian"
      "orbstack"
      "pop"
      "raindropio"
      {
        name = "secretive";
        args = { appdir = "/Applications"; };
      }
      "sonos-s1-controller"
      {
        name = "spotify";
        args = { require_sha = false; }; # missing sha256 checksum
      }
      "teamviewer"
      "tuple"
      "tweeten"
      "vlc"
      "wezterm"
      {
        # Zoom must also be installed under /Applications
        name = "zoom";
        args = { appdir = "/Applications"; };
      }
    ];

    caskArgs = {
      appdir = "~/Applications/Homebrew Apps";
      no_quarantine = true;
      require_sha = true;
    };
  };
}
