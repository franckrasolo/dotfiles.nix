{ pkgs, user, ... }:
let
  asUser = pkgs.runCommand "macrunner-as-user" { } ''
    install -Dm0755 ${./macrunner-as-user.sh} $out/bin/macrunner-as-user
  '';

  contextify = pkgs.runCommand "macrunner-contextify" { } ''
    install -Dm0755 ${./macrunner-contextify.sh} $out/bin/macrunner-contextify
  '';
in
{
  environment.systemPackages = [ asUser contextify ];

  environment.etc."sudoers.d/10-mac-runner-context".text = ''
    # Enter Mac Runner's service-user launchd context; ends as _macrunner, never root.
    _macrunner ALL=(root) NOPASSWD: \
      ${asUser}/bin/macrunner-as-user, \
      /run/current-system/sw/bin/macrunner-as-user

    ${user.accountName} ALL=(root) NOPASSWD: \
      ${contextify}/bin/macrunner-contextify, \
      /run/current-system/sw/bin/macrunner-contextify
  '';
}
