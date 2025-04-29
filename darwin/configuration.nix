{ pkgs, config, user, ... }:

{
  imports = [
    ./homebrew
    ./hammerspoon
    ./macOS
    ./aerospace
    ./jankyborders
    ./skhd
  ];

  # /etc/nix/nix.conf -> /etc/static/nix/nix.conf

  nix.settings = {
    access-tokens = "";

    auto-optimise-store = false;

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

  nix.extraOptions = ''
    keep-outputs = false
    keep-derivations = false
    experimental-features = nix-command flakes
  '';

  sops = {
    age = {
      keyFile = "${user.homeDirectory}/dev/dotfiles.nix/secrets/bootstrap-key.txt";
      sshKeyPaths = [];
      generateKey = true;
    };
    gnupg.sshKeyPaths = [];

    defaultSopsFile = ../secrets/bootstrap.yaml;
    secrets.nix-github-api-token = {};
    templates."github-token" = {
      content = ''
        ${config.sops.placeholder.nix-github-api-token}
      '';
      owner = user.accountName;
    };
  };

  # auto-upgrade both the nix package and the daemon service
  services.nix-daemon.enable = true;
  nix.package = pkgs.unstable.nixVersions.latest;
  nix.useDaemon = true;

  nixpkgs.config.allowBroken = true;
  nixpkgs.config.allowUnfree = true;


  # used for backwards compatibility (check the change log first)
  system.stateVersion = 4;

  environment.darwinConfig = "$HOME/dev/dotfiles.nix/darwin/configuration.nix";

  environment.shells = [
    pkgs.zsh
    pkgs.unstable.nushell
  ];

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
      ${pkgs.coreutils}/bin/env nix-env -p /nix/var/nix/profiles/system --set /nix/store/*, \
      ${pkgs.coreutils}/bin/env /nix/store/*/activate, \
      ${coreutils}/bin/cp ${_1password-cli}/bin/op /usr/local/bin/op, \
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

  system.activationScripts.preUserActivation.text = with pkgs.unstable; ''
    export PATH=${user.homeDirectory}/dev/dotfiles.nix/darwin/bin:$PATH

    launchctl setenv XDG_CACHE_HOME   ~/.xdg/cache
    launchctl setenv XDG_CONFIG_HOME  ~/.xdg/config
    launchctl setenv XDG_DATA_HOME    ~/.xdg/local/share
    launchctl setenv XDG_STATE_HOME   ~/.xdg/local/state
    launchctl setenv GRADLE_USER_HOME ~/.xdg/local/share/gradle
    launchctl setenv DOCKER_CONFIG    ~/.xdg/config/docker
    launchctl setenv KUBECONFIG       ~/.xdg/config/kube

    # 1Password integration requires the CLI binary at a specific location
    sudo ${coreutils}/bin/cp ${_1password-cli}/bin/op /usr/local/bin/op

    # set default handlers for Apple UTIs, URL schemes, file extensions, and MIME types
#   duti $XDG_CONFIG_HOME/duti/   # must run *after* home-manager
    duti ~/dev/dotfiles.nix/home/duti/
  '';

  system.activationScripts.postUserActivation.text = with pkgs.unstable; ''
    # load Bunch automations – https://bunchapp.co/
    open 'x-bunch://setPref?configDir=~/.xdg/config/bunches'
   sudo ${gnused}/bin/sed -i \
     -E "s/access-tokens = .*/access-tokens = github.com=$(cat ${config.sops.templates.github-token.path})/" \
     /etc/static/nix/nix.conf
  '';

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
      ../home
      { xdg.configFile."bunches".source = ./bunches; }
    ];
  };

  fonts.packages = with pkgs.unstable; [
    cascadia-code
    font-awesome
    monaspace
    ubuntu_font_family
    nerd-fonts.hasklug
    nerd-fonts.jetbrains-mono
  ];
}
