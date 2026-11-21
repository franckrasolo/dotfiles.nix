{ config, darwinConfig, lib, pkgs, ... }:

with pkgs.unstable;
let
  label = "org.nix-community.home.save-github-auth";

  saveGitHubAuth = pkgs.writeShellScript "save-github-auth" ''
    set -euo pipefail
    export GH_PROMPT_DISABLED=1

    token=${lib.escapeShellArg darwinConfig.sops.templates.github-token.path}
    started=$(date +%s)
    deadline=$((SECONDS + 900))
    while :; do
      if [ -s "$token" ]; then
        modified=$(stat -f %m "$token" 2>/dev/null || echo 0)
        # Wait for this activation's render, not a token left from the previous one.
        if [ "$modified" -ge "$((started - 5))" ]; then
          break
        fi
      fi
      if [ "$SECONDS" -ge "$deadline" ]; then
        echo "GitHub token was not refreshed after 900s; giving up" >&2
        exit 1
      fi
      sleep 1
    done

    gh_config_dir=${lib.escapeShellArg "${config.xdg.configHome}/gh"}
    mkdir -p "$gh_config_dir"
    ln -sfn ${lib.getExe gh} /opt/homebrew/bin/gh
    ln -sfn "$gh_config_dir" "$HOME/.config/gh"

    install -m 600 ${./gh.yaml} "$gh_config_dir/config.yml"
    ${lib.getExe gh} auth login --with-token < "$token"
  '';
in
{
  home.packages = [
    gh
  ];

  launchd.agents.save-github-auth = {
    enable = true;
    config = {
      Label = label;
      Program = saveGitHubAuth;
      StandardOutPath = "${config.home.homeDirectory}/Library/Logs/save-github-auth.out.log";
      StandardErrorPath = "${config.home.homeDirectory}/Library/Logs/save-github-auth.err.log";
    };
  };

  # restart the agent on every switch so token changes are picked up
  home.activation.startSaveGitHubAuth = lib.hm.dag.entryAfter [ "setupLaunchAgents" ] ''
    if ! run /bin/launchctl kickstart -k "gui/$(id -u)/${label}"; then
      warnEcho "Failed to start the ${label} agent"
    fi
  '';
}
