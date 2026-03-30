{ pkgs, user, ... }:

{
  imports = [
    ./homebrew
    ./macOS
    ./nix
    ./jankyborders
    ./skhd
    ./security.nix
  ];

  # used for backwards compatibility (check the change log first)
  system.stateVersion = 4;

  environment = with pkgs.unstable; {
    darwinConfig = "${user.dotfiles}/darwin/configuration.nix";

    shells = [
      nushell
      zsh
    ];

    systemPackages = [
      cacert
      duti
      net-news-wire
      sketchybar
    ];
  };

  programs.nix-index = {
    enable = true;
    package = pkgs.unstable.nix-index;
  };

  # create /etc/<shell>rc that loads the nix-darwin environment
  programs.zsh.enable = true;

  system.activationScripts.preActivation.text = ''
    # Fix for /etc/{bashrc,zshenv,zshrc} being restored by macOS on reboot.
    #
    # This script runs before the 'etc' activation step, renaming regular files
    # that would otherwise cause darwin-rebuild to abort.

    for file in /etc/{bashrc,zshenv,zshrc}; do
      if [ -f "$file" ] && [ ! -L "$file" ]; then
        # rename stock macOS file to allow nix-darwin to manage it
        mv "$file" "$file".before-nix-darwin
      fi
    done
  '';

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
