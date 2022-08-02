{ pkgs, ... }:

# enable sudo authentication with Touch ID
#
# note: macOS resets /etc/pam.d/sudo with every system update
#
# adapted from https://github.com/LnL7/nix-darwin/pull/228 (pending)
let
  file = "/etc/pam.d/sudo";
in
{
  system.activationScripts.extraActivation.text = ''
    echo >&2 "setting up PAM..."

    # enable sudo Touch ID authentication, if not already enabled
    if ! grep 'pam_tid.so' ${file} > /dev/null; then
      ${pkgs.gnused}/bin/sed -i '2i\
    auth       sufficient     pam_tid.so  # nix-darwin
      ' ${file}
    fi
  '';
}
