{ config, pkgs, user, ... }:

{
  imports = [
    ./homebrew
    ./macOS
    ./skhd
    ./spacebar
  ];

  nix.extraOptions = ''
    keep-outputs = false
    keep-derivations = false
    experimental-features = nix-command flakes
  '';

  # auto-upgrade both the nix package and the daemon service
  services.nix-daemon.enable = true;
  nix.package = pkgs.nixUnstable;
  nix.useDaemon = true;

  nixpkgs.config.allowBroken = true;
  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    auto-optimise-store = true;

    trusted-substituters = [
      "https://cache.iog.io" # for haskell.nix
    ];

    trusted-public-keys = [
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
    ];

    allowed-users = [ user.accountName ];
    trusted-users = [ user.accountName "root" ];

    max-jobs = 48;  # max 3 jobs per core
    cores    = 16;  # total number of logical cores: sysctl -n hw.ncpu
  };

  # used for backwards compatibility (check the change log first)
  system.stateVersion = 4;

  # recreate /run/current-system symlink after boot
  services.activate-system.enable = true;

  environment.darwinConfig   = "$HOME/dev/dotfiles.nix/darwin/configuration.nix";
  environment.shells         = with pkgs.unstable; [ zsh nushell ];
  environment.systemPackages = with pkgs.unstable; [
    cacert
    duti
    net-news-wire
    sketchybar
  ];

  # skip sudo authn for frequently used commands
  environment.etc."sudoers.d/10-nix-commands".text = with pkgs.unstable; ''
    ${user.accountName} ALL=(ALL:ALL) NOPASSWD: \
      /run/current-system/sw/bin/darwin-rebuild, \
      /run/current-system/sw/bin/nix-build, \
      /run/current-system/sw/bin/nix-channel, \
      /run/current-system/sw/bin/nix-collect-garbage, \
      /run/current-system/sw/bin/nix-env, \
      /nix/store/*/activate, \
      ${coreutils}/bin/cp ${_1password}/bin/op /usr/local/bin/op, \
      /etc/profiles/per-user/${user.accountName}/bin/openconnect, \
      /usr/bin/dscacheutil, \
      /usr/bin/killall, \
      /usr/bin/pkill, \
      /usr/bin/renice
  '';

  security = {
    pam.enableSudoTouchIdAuth = true;

    # register additional (MITM) certificates
    pki.certificateFiles = [
#     "/etc/static/ssl/certs/nscacert.pem"
    ];
  };

  programs.nix-index.enable = true;

  # create /etc/<shell>rc that loads the nix-darwin environment
  programs.zsh.enable = true;

  users.users."${user.accountName}" = {
    description = user.fullName;
    home = user.homeDirectory;
    shell = pkgs.unstable.zsh;
  };

  time.timeZone = "Europe/London";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users."${user.accountName}" = pkgs.lib.mkMerge [
      (import ../home { inherit pkgs user; })
      { xdg.configFile."bunches".source = ./bunches; }
    ];
  };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs.unstable; [
      font-awesome
      ubuntu_font_family
      (nerdfonts.override { fonts = [ "Hasklig" "JetBrainsMono" ]; })
    ];
  };
}
