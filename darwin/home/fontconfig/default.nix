{ pkgs, ... }:

with pkgs.unstable;
let
  fontsConf = pkgs.writeText "fonts.conf" ''
    <?xml version='1.0'?>
    <!DOCTYPE fontconfig SYSTEM "fonts.dtd">

    <fontconfig>
      <include ignore_missing="yes">${fontconfig.out}/etc/fonts/fonts.conf</include>

      <!-- macOS system and user font paths -->
      <dir>/System/Library/Fonts</dir>
      <dir>/Library/Fonts</dir>
      <dir>~/Library/Fonts</dir>
    </fontconfig>
  '';
in
{
  home.sessionVariables = {
    FONTCONFIG_FILE = "${fontsConf}";
    FONTCONFIG_PATH = "${fontconfig.out}/etc/fonts";
  };
}
