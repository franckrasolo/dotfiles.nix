#!/usr/bin/env zsh

set -euo pipefail

session_path=${1:?a path to a directory is required}

if [[ -f ".config/tmux/session.yaml" ]]; then
  tmuxp_config=".config/tmux/session.yaml"
else
  tmuxp_config="$XDG_CONFIG_HOME/tmuxp/default.yaml"
fi

export SESSION_NAME=$(basename $session_path | sed 's/\./_/')

if [[ $SESSION_NAME == $(tmux display-message -p '#S') ]]; then
  tmux rename-session "${SESSION_NAME}~"
fi

tmuxp load --yes $tmuxp_config
tmux kill-session -t "${SESSION_NAME}~"
