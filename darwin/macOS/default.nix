{ user, ... }:

{
  imports = [
    ./dock.nix
    ./finder.nix
    ./keyboard.nix
    ./trackpad.nix
    ./sound.nix
    ./spaces.nix
    ./miscellaneous.nix
    ./postUserActivation.nix
  ];
}
