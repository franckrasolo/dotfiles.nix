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
      "megasync"
      "obsidian"
      "pop"
      "screen"
      "secretive"
      "sonos-s1-controller"
      "soundflower"
      "spotify"
      "teamviewer"
      "temurin17"
      "tuple"
      "tweeten"
      "twitch"
      "vlc"
      "wavebox"
    ];

    masApps = {};

    extraConfig = ''
      # usage: https://github.com/Homebrew/homebrew-bundle

      cask_args appdir: "~/Library/Homebrew/Applications", require_sha: "true"

      # 1Password warns that it will neither fill nor save logins in browsers
      # when it isn't installed under /Applications
      cask "1password", args: { appdir: "/Applications", require_sha: "true" }

      # Zoom must also be installed under /Applications
      cask "zoom", args: { appdir: "/Applications", require_sha: "true" }
    '';
  };
}
