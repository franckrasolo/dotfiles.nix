{ pkgs, config, user, ... }:

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
    darwinConfig = "$HOME/dev/dotfiles.nix/darwin/configuration.nix";

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
