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
      "homebrew/cask"
      "homebrew/cask-versions"
      "martido/homebrew-graph"
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
        name = "loopback";
        args = { require_sha = false; }; # missing sha256 checksum
      }
      "megasync"
      "obsidian"
      "pop"
      "secretive"
      "sonos-s1-controller"
      "spotify"
      "teamviewer"
      "temurin17"
      "tuple"
      "tweeten"
      "vlc"
      "wavebox"
      {
        # Zoom must also be installed under /Applications
        name = "zoom";
        args = { appdir = "/Applications"; };
      }
    ];

    caskArgs = {
      appdir = "~/Library/Homebrew/Applications";
      require_sha = true;
    };
  };
}
