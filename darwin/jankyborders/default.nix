{ pkgs, ... }:

{
  services.jankyborders = {
    enable   = true;
    package  = pkgs.unstable.jankyborders;
    ax_focus = false;

    active_color   = "glow(0xFF34BF91)";
    inactive_color = "glow(0x46DD60FF)";

    hidpi = true;
    style = "round";
    width = 10.0;

    blacklist = [];
    whitelist = [];
  };
}
