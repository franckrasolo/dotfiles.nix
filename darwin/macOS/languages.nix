{ user, ... }:

{
  home-manager.users.${user.accountName}.targets.darwin.defaults.NSGlobalDomain = {
    AppleLanguages = [ "en" ];
    AppleLocale    = "en_GB@currency=GBP";

    AppleMeasurementUnits = "Centimeters";
    AppleMetricUnits      = true;
    AppleTemperatureUnit  = "Celsius";
  };
}