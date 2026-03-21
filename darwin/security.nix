{ config, pkgs, user, ... }:

{
  security = {
    pam.services.sudo_local.touchIdAuth = true;

    # register additional (MITM) certificates
    pki.certificateFiles = [
#     "/etc/static/ssl/certs/nscacert.pem"
    ];
  };

  sops = {
    age = {
      keyFile = "${user.dotfiles}/home/fnox/age.txt";
      sshKeyPaths = [];
      generateKey = true;
    };
    gnupg.sshKeyPaths = [];

    defaultSopsFile = ../secrets/bootstrap.yaml;
    secrets.nix-github-api-token = {};
    templates."github-token" = {
      content = ''
        ${config.sops.placeholder.nix-github-api-token}
      '';
      owner = user.accountName;
    };
  };

  system.activationScripts.addGitHubAccessToken.text = with pkgs.unstable; ''
    sudo ${gnused}/bin/sed -i \
      -E "s/access-tokens = .*/access-tokens = github.com=$(cat ${config.sops.templates.github-token.path})/" \
      /etc/static/nix/nix.conf
  '';

  system.primaryUser = user.accountName;

  # skip sudo authn for frequently used commands
  environment.etc."sudoers.d/10-nix-commands".text = with pkgs.unstable; ''
    ${user.accountName} ALL=(ALL:ALL) NOPASSWD: \
      /run/current-system/sw/bin/darwin-rebuild, \
      /run/current-system/sw/bin/nix-build, \
      /run/current-system/sw/bin/nix-channel, \
      /run/current-system/sw/bin/nix-collect-garbage, \
      ${pkgs.coreutils}/bin/env nix-env -p /nix/var/nix/profiles/system --set /nix/store/*, \
      ${pkgs.coreutils}/bin/env /nix/store/*/activate, \
      ${coreutils}/bin/cp ${_1password-cli}/bin/op /usr/local/bin/op, \
      /etc/profiles/per-user/${user.accountName}/bin/openconnect, \
      /usr/bin/dscacheutil, \
      /usr/bin/killall, \
      /usr/bin/pkill, \
      /usr/bin/renice
  '';
}
