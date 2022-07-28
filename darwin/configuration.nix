{ config, pkgs, user, ... }:

{
  imports = [
    ./homebrew
    ./macOS
    ./skhd
    ./spacebar
  ];

  nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    gc-keep-outputs = false
    gc-keep-derivations = false
    auto-optimise-store = true
    experimental-features = nix-command flakes
  '';

  # auto-upgrade both the nix package and the daemon service
  services.nix-daemon.enable = true;
  nix.useDaemon = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "1password"
  ];

  nix.binaryCaches = [
    "https://hydra.iohk.io" # for haskell.nix
  ];

  nix.binaryCachePublicKeys = [
    "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
  ];

  nix.trustedBinaryCaches = config.nix.binaryCaches;

  nix.allowedUsers = [ user.accountName ];
  nix.trustedUsers = [ user.accountName "root" ];

  nix.maxJobs    = 48;  # max 3 jobs per core
  nix.buildCores = 16;  # total number of logical cores: sysctl -n hw.ncpu

  # used for backwards compatibility (check the change log first)
  system.stateVersion = 4;

  # recreate /run/current-system symlink after boot
  services.activate-system.enable = true;

  environment.darwinConfig   = "$HOME/dev/dotfiles.nix/darwin/configuration.nix";
  environment.shells         = with pkgs; [ zsh nushell ];
  environment.systemPackages = with pkgs; [ cacert duti ];

  # skip sudo authn for frequently used commands
  environment.etc."sudoers.d/10-nix-commands".text = ''
    ${user.accountName} ALL=(ALL:ALL) NOPASSWD: \
      /run/current-system/sw/bin/darwin-rebuild, \
      /run/current-system/sw/bin/nix-build, \
      /run/current-system/sw/bin/nix-channel, \
      /run/current-system/sw/bin/nix-collect-garbage, \
      /run/current-system/sw/bin/nix-env, \
      /nix/store/*/activate, \
      /usr/bin/dscacheutil, \
      /usr/bin/killall, \
      /usr/bin/renice
  '';

  # register any MITM certificates
 security.pki.certificateFiles = [
#   "/etc/static/ssl/certs/nscacert.pem"
 ];

  programs.nix-index.enable = true;

  # create /etc/<shell>rc that loads the nix-darwin environment
  programs.zsh.enable = true;

  users.users."${user.accountName}" = {
    description = user.fullName;
    home = user.homeDirectory;
    shell = pkgs.zsh;
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
    fonts = with pkgs; [
      font-awesome
      ubuntu_font_family
      (nerdfonts.override { fonts = [ "Hasklig" "JetBrainsMono" ]; })
    ];
  };
}
