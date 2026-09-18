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

_cache_completion aube aube completion zsh
_cache_completion bd bd completion zsh
_cache_completion dive dive completion zsh
_cache_completion fnox fnox completion zsh
_cache_completion fx fx --comp zsh
_cache_completion gh gh completion --shell zsh
_cache_completion glab glab completion --shell zsh
_cache_completion herdr herdr completion zsh
_cache_completion k3d k3d completion zsh

# source: https://michaelheap.com/kubectl-alias-autocomplete/
#
# `kubectl completion zsh` too slow
# source: https://gist.github.com/weltonrodrigo/ad17620e678c7231330aa73043cee8a2
_cache_completion kubectl eval HTTPS_PROXY=1:1 kubectl completion zsh
compdef k='kubectl'

_cache_completion leaf leaf --auto-complete zsh:dump
_cache_completion limactl limactl completion zsh
_cache_completion mise mise completion zsh
_cache_completion omp zsh -c "omp completions zsh"
_cache_completion opencode opencode completion
_cache_completion smolvm cat $XDG_CONFIG_HOME/zsh/smolvm.zsh
_cache_completion tv tv completions zsh
_cache_completion usage usage --completions zsh

# see https://github.com/zellij-org/zellij/issues/2316
_cache_completion zellij zsh -c "zellij setup --generate-completion zsh | sed '/_zellij \"\$@\"/d'"

_cache_completion zsh-patina zsh-patina completion
