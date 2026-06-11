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
      extraFlags = [ "--force-cleanup" ];
    };

    taps = [
      "beadbox/cask"
      "martido/homebrew-graph"
      "nikitabobko/tap"
    ];

    brews = [
      "elio"
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
      {
        name = "amadeus-pro";
        args = { require_sha = false; }; # missing sha256 checksum
      }
      "arc"
      {
        name = "audio-hijack";
        args = { require_sha = false; }; # missing sha256 checksum
      }
      "beadbox"
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
      "cmux"
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
      "finetune"
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
      {
        name = "lm-studio";
        args = { appdir = "/Applications"; };
      }
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
      "shottr"
      "sonos-s1-controller"
      {
        name = "speechify-voice-ai";
        args = { require_sha = false; }; # missing sha256 checksum
      }
      {
        name = "spotify";
        args = { require_sha = false; }; # missing sha256 checksum
      }
      "tailscale-app"
      "teamviewer"
      "telegram"
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
