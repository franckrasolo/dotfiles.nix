{ pkgs, user, ... }:

{
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

  nix.package = pkgs.unstable.nixVersions.latest;

  nixpkgs.config.allowBroken = true;
  nixpkgs.config.allowUnfree = true;

# nixpkgs.overlays = map import [
#   ./yabai/overlay.nix
# ];
}
