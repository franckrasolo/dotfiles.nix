{ config, pkgs, user, ... }:

{
  sops = {
    age = {
      keyFile = "${user.homeDirectory}/dev/dotfiles.nix/secrets/bootstrap-key.txt";
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
}
