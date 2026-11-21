{ config, darwinConfig, lib, pkgs, ... }:

with pkgs.unstable;
{
  home.packages = [
    gh
  ];

  home.activation.saveGitHubAuth = with lib; hm.dag.entryAfter [ "writeBoundary" ] ''
    verboseEcho "Persisting GitHub authentication to the macOS keychain..."

    # MacRunner looks for /opt/homebrew/bin/gh and /usr/local/bin/gh
    ln -sfn ${getExe gh} /opt/homebrew/bin/gh

    # the MacRunner app does not inherit XDG_CONFIG_HOME so gh gets its config from ~/.config/gh
    gh_config_dir="${config.xdg.configHome}/gh"
    mkdir -p "$gh_config_dir"
    ln -sfn "$gh_config_dir" ~/.config/gh

    # gh rewrites config.yml and hosts.yml so they can't be read-only Nix store symlinks
    install -m 600 ${./gh.yaml} "$gh_config_dir/config.yml"

    # store GitHub authentication in the macOS keychain so that the MacRunner app picks it up
    cat ${darwinConfig.sops.templates.github-token.path} | ${getExe gh} auth login --with-token
  '';
}
