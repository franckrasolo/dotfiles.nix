_cache_completion() {
  local name=$1
  local cache=$XDG_CACHE_HOME/zsh/completions/_$1.zsh
  shift
  local bin=$(command -v $name) || return
  if [[ ! -s $cache || $bin -nt $cache ]]; then
    mkdir -p ${cache:h}
    "$@" >| $cache
  fi
  source $cache
}

#dagger completion zsh | tee /usr/local/share/zsh/site-functions/_dagger &> /dev/null

_cache_completion fx fx --comp zsh
_cache_completion gh gh completion --shell zsh
_cache_completion glab glab completion --shell zsh

#source /etc/profiles/per-user/$USER/share/zsh/site-functions/_gradle
#__gradle-completion-init

#kitty +complete setup zsh | source /dev/stdin

# source: https://michaelheap.com/kubectl-alias-autocomplete/
#
# `kubectl completion zsh` too slow
# source: https://gist.github.com/weltonrodrigo/ad17620e678c7231330aa73043cee8a2
_cache_completion kubectl eval HTTPS_PROXY=1:1 kubectl completion zsh
compdef k='kubectl'

_cache_completion mise mise completion zsh

# see https://github.com/zellij-org/zellij/issues/2316
_cache_completion zellij zsh -c "zellij setup --generate-completion zsh | sed '/_zellij \"\$@\"/d'"

_cache_completion zsh-patina zsh-patina completion
