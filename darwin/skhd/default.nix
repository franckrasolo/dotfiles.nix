{ pkgs, user, ... }:

{
  services.skhd = {
    enable  = true;
    package = pkgs.unstable.skhd;
    skhdConfig = let
      skhdEnv = rec {
        modMask  = "cmd";
        moveMask = "cmd + ctrl";
        noOp     = "/dev/null";
        prefix   = "yabai -m";

        firstOrSecond = { first, second }: domain:
          "${prefix} ${domain} --focus ${first} || ${prefix} ${domain} --focus ${second}";

        nextOrFirst = firstOrSecond { first = "next"; second = "first"; };
        prevOrLast  = firstOrSecond { first = "prev"; second = "last";  };
      };
    in
      with builtins; concatStringsSep "\n" (map (f: import f { inherit skhdEnv user; }) [
        ./exclusions.nix
        ./launchers.nix
      ]);
  };
}
