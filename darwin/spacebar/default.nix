{ pkgs, ... }:

{
  services.spacebar = {
    enable  = true;
    package = pkgs.spacebar;
    config  = {
      text_font        = ''"Ubuntu:Bold:14"'';
      icon_font        = ''"Font Awesome 6 Free:Solid:12"'';
      background_color = "0xff000000";
      foreground_color = "0xffa8a8a8";
      space_icon_color = "0xff458588";
      space_icon_strip = "    ";
      power_icon_strip = " ";
      space_icon       = " ";
      clock_icon       = " ";
      clock_format     = "%a %d %b %Y　%H﹕%M﹕%S";
    };
  };
}
