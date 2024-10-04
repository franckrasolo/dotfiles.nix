{ user, ... }:

{
  imports = [
    ./dock.nix
    ./finder.nix
    ./keyboard.nix
    ./languages.nix
    ./menubar.nix
    ./trackpad.nix
    ./sound.nix
    ./spaces.nix
    ./miscellaneous.nix
  ];
}
