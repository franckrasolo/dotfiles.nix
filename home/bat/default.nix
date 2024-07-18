{ pkgs, lib, ... }:

{
  home.packages = [ pkgs.unstable.bat ];

  xdg.configFile."bat/config".source  = pkgs.writeText "config" ''
    --map-syntax="*{j,J}ustfile*:Makefile"
    --pager="less -FR"
    --theme="gruvbox-dark"
  '';

  home.activation.batCache = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    $VERBOSE_ECHO "Rebuilding the bat theme cache"
    export BAT_CACHE_PATH=$HOME/.xdg/cache/bat
    export BAT_CONFIG_DIR=$HOME/.xdg/config/bat
    $DRY_RUN_CMD ${lib.getExe pkgs.unstable.bat} cache --build
  '';
}
