{ pkgs, config, user, ... }:

{
  imports = [
    ./homebrew
    ./macOS
    ./nix
    ./jankyborders
    ./skhd
    ./sops.nix
  ];

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
    pam.services.sudo_local.touchIdAuth = true;

    # register additional (MITM) certificates
    pki.certificateFiles = [
#     "/etc/static/ssl/certs/nscacert.pem"
    ];
  };

  system.primaryUser = user.accountName;

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
      ./home
      ../home
    ];
  };

  fonts.packages = with pkgs.unstable; [
    cascadia-code
    font-awesome
    monaspace
    ubuntu-classic
    nerd-fonts.hasklug
    nerd-fonts.jetbrains-mono
  ];
}
