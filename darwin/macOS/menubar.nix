{ user, ... }:

{
  system.defaults.menuExtraClock = {
    IsAnalog   = false;
    Show24Hour = true;
    ShowAMPM   = false;
    ShowDate   = 1;
    ShowDayOfMonth = true;
    ShowDayOfWeek  = true;
    ShowSeconds    = true;
  };

  home-manager.users.${user.accountName}.targets.darwin.defaults."com.apple.menuextra.clock" = {
    FlashDateSeparators = true;
  };
}
