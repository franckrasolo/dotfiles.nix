{ user, ... }:

{
  imports = [
    ./dock.nix
    ./finder.nix
    ./keyboard.nix
    ./languages.nix
    ./menuExtraClock.nix
    ./trackpad.nix
    ./sound.nix
    ./spaces.nix
    ./miscellaneous.nix
    ./postUserActivation.nix
  ];
}
