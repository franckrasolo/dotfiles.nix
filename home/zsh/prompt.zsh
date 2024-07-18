zmodload zsh/datetime

path_aliases=(
  "~/.xdg/cache=xdg_cache"
  "~/.xdg/config=xdg_config"
  "~/.xdg/local/share=xdg_data"
  "~/.xdg/cache/antibody=@antibody"
  "~/.xdg/config/vim/plugged=vim-plugins"
  "~/.nix-defexpr/channels/nixpkgs=@nixpkgs"
  "nix/var/nix/profiles/per-user/$USER/channels/nixpkgs=@nixpkgs"
  "nix/var/nix/profiles/per-user/$USER/profile=@nix-profile"
  "~/dev/dotfiles.nix=@dotfiles"
)

intercalate() { local IFS="$1"; shift; echo "$*"; }

preexec() {
  __TIMER=$EPOCHREALTIME
}

powerline_go_precmd() {
  local __ERRCODE=$?
  local __DURATION=0

  if [ -n $__TIMER ]; then
    local __ERT=$EPOCHREALTIME
    __DURATION="$(($__ERT - ${__TIMER:-__ERT}))"
  fi

  powerline_go_args=(
    -eval
    -shell zsh
    -cwd-max-depth 5
    -cwd-max-dir-size -1
    -cwd-mode 'fancy'
    -mode 'patched'
    -duration $__DURATION
    -error $__ERRCODE
    -jobs ${${(%):%j}:-0}
    -modules 'nix-shell,ssh,aws,docker,kube,terraform-workspace,perms,cwd,venv,jobs,duration'
    -modules-right 'git,exit,time'
    -shorten-eks-names
    -shorten-gke-names
    -truncate-segment-width 5
    -path-aliases $(intercalate ',' $path_aliases)
    -theme $XDG_CONFIG_HOME/zsh/powerline-go-amoled-theme.json
  )

  eval "$(powerline-go ${powerline_go_args[@]})"

  unset __TIMER
}

install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_go_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_go_precmd)
}

if [ "$TERM" != "linux" ]; then
  install_powerline_precmd
fi
