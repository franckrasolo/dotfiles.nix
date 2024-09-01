profiling=false && zmodload zsh/zprof || true # https://getantibody.github.io/even-faster/

typeset -U path cdpath fpath manpath # prevent duplicates in paths

#source $HOME/.nix-profile/etc/profile.d/nix.sh
source /etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh

# some programs (e.g. ripgrep, taskwarrior) installed by Nix may also have zsh completions
for profile in ${(z)NIX_PROFILES}; do
  fpath+=(
    "$profile/share/zsh/site-functions"
    "$profile/share/zsh/$(fzf --version | awk '{ print $1 }')/functions"
    "$profile/share/zsh/vendor-completions"
  )
done

# using http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -o errexit
set -o pipefail

ZSH_CONFIG_HOME=${ZDOTDIR}
[ -f "${ZSH_CONFIG_HOME}/plugins.zsh" ] && source "${ZSH_CONFIG_HOME}/plugins.zsh"

set -o nounset
source "${ZSH_CONFIG_HOME}/colours.zsh"
source "${ZSH_CONFIG_HOME}/options.zsh"
source "${ZSH_CONFIG_HOME}/aliases.zsh"
source "${ZSH_CONFIG_HOME}/aliases.docker.zsh"
source "${ZSH_CONFIG_HOME}/aliases.git.zsh"
source "${ZSH_CONFIG_HOME}/aliases.k8s.zsh"
source "${ZSH_CONFIG_HOME}/aliases.nix.zsh"
source "${ZSH_CONFIG_HOME}/bindkeys.zsh"

set +o nounset
source "${ZSH_CONFIG_HOME}/completions.zsh"
source "${ZSH_CONFIG_HOME}/prompt.zsh"

eval "$(/opt/homebrew/bin/brew shellenv)"
#eval "$(brew shellenv)"
eval "$(direnv hook zsh)"
eval "$(pdm --pep582 zsh)"
eval "$(zoxide init --cmd cd zsh)"
source <(fx --comp zsh)

# see https://github.com/zellij-org/zellij/issues/2316
source <(zellij setup --generate-completion zsh | sed '/_zellij "$@"/d')

set +o errexit
$profiling && zprof || true
