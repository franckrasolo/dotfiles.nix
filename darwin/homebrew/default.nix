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
      "martido/homebrew-graph"
      "nikitabobko/tap"
      "steipete/tap"
    ];

    brews = [
      "headson"
    ];

    casks = [
      {
        # 1Password warns that it will neither fill nor save logins
        # in browsers when it isn't installed under /Applications
        name = "1password";
        args = { appdir = "/Applications"; };
      }
      "aerospace"
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
      "deskpad"
      "discord"
      {
        name = "docker-desktop";
        args = { appdir = "/Applications"; };
      }
      "dropbox"
      {
        name = "duckduckgo";
        args = { appdir = "/Applications"; };
      }
      "firefox"
      "opera"
      "zen"
      "expressvpn"
      {
        name = "hammerspoon";
        args = { appdir = "/Applications"; };
      }
      "jetbrains-toolbox"
      "keycastr"
      "kitty"
      "localsend"
      {
        name = "logitech-options";
        args = { require_sha = false; }; # missing sha256 checksum
      }
      {
        name = "logi-options+";
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
      {
        name = "orbstack";
        args = { appdir = "/Applications"; };
      }
      "pop-app"
      "raindropio"
      {
        name = "secretive";
        args = { appdir = "/Applications"; };
      }
      "repobar"
      "shottr"
      "sonos-s1-controller"
      {
        name = "spotify";
        args = { require_sha = false; }; # missing sha256 checksum
      }
      "teamviewer"
      "tuple"
      "vlc"
      "wezterm"
      {
        name = "wispr-flow";
        args = { appdir = "/Applications"; };
      }
      {
        # Zoom must also be installed under /Applications
        name = "zoom";
        args = { appdir = "/Applications"; };
      }
    ];

    caskArgs = {
      appdir = "~/Applications/Homebrew Apps";
      require_sha = true;
    };
  };
}
