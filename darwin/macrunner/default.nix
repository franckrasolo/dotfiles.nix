{ pkgs, ... }:
let
  asUser = pkgs.runCommand "macrunner-as-user" { } ''
    install -Dm0755 ${./macrunner-as-user.sh} $out/bin/macrunner-as-user
  '';
in
{
  environment.systemPackages = [ asUser ];

  environment.etc."sudoers.d/10-mac-runner-context".text = ''
    # Enter Mac Runner's service-user launchd context; ends as _macrunner, never root.
    _macrunner ALL=(root) NOPASSWD: ${asUser}, /run/current-system/sw/bin/macrunner-as-user
  '';
}
