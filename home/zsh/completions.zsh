autoload -Uz compinit colors && colors

if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/completion.zsh"
fi

ZCOMPDUMP=$XDG_CACHE_HOME/zsh/zcompdump # https://gist.github.com/ctechols/ca1035271ad134841284#file-compinit-zsh
if [[ -n $ZCOMPDUMP(#qN.mh+24) ]]; then # only update the completion cache once a day
  compinit -d $ZCOMPDUMP
else
  compinit -d $ZCOMPDUMP -C
fi

zmodload -i zsh/complist # completion listing extensions

# enable completion caching, use rehash to clear
zstyle ':completion:*' use-cache  on
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/completions

zstyle ':completion:*' file-sort    modification reverse      # list most recently modified files first
zstyle ':completion:*' group-name   ''                        # group results by category
zstyle ':completion:*' menu         select=2                  # show completion menu if 2 or more items are available
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' verbose      yes

# make the list prompt friendly
zstyle ':completion:*' list-colors    ${(s.:.)LS_COLORS}      # use the same colours as ls
#zstyle ':completion:*' list-prompt    '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' list-separator ' → '
zstyle ':completion:*' matcher-list   'm:{a-zA-Z}={A-Za-z}'   # match case insensitive

# make the selection prompt friendly when there are a lot of choices
zstyle ':completion:*' select-prompt  '%Sscrolling active: current selection at %p%s'

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description 'specify: %d' # generate descriptions with magic
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*:manuals' separate-sections true

zstyle ':completion:*::::' completer _expand _complete _ignored _approximate # list of completers to use

# TODO: tidy up the sections below using https://dustri.org/b/my-zsh-configuration.html

# page large lists
#zstyle ':completion:*:default' list-prompt '%s%m matches%s'
# display a large list as a menu
#zstyle ':completion:*:default' menu 'select=0'

# formatting and messages

#zstyle ':completion:*:descriptions'  format '%B%d%b'
#zstyle ':completion:*:corrections'   format '%B%d (errors: %e)%b'
#zstyle ':completion:*:messages'      format '%d'
#zstyle ':completion:*:warnings'      format 'No matches for: %d'

zstyle ':completion:*'               format "---[ %B%F{074}%d%f%b ]---"
#zstyle ':completion:*:descriptions'  format "%{$fg[green]%}%d%{$reset_color%}"
#zstyle ':completion:*:corrections'   format "%{$fg[orange]%}%d%{$reset_color%}"
#zstyle ':completion:*:messages'      format "%{$fg[red]%}%d%{$reset_color%}"
#zstyle ':completion:*:warnings'      format "%{$fg[red]%}%d%{$reset_color%}"

# autocompletion of privileged environments in privileged commands
# when a command starts with sudo, completion scripts will also try to determine available completions
zstyle ':completion::complete:*' gain-privileges 1

# skip items already on the line
zstyle ':completion::*:(rm|v):*' ignore-line true

# do not suggest the directory we are already in (../here)
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion::approximate*:*' prefix-needed  false

# history
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes

# kill menu
zstyle ':completion:*:kill:*'      force-list always
zstyle ':completion:*:killall:*'   force-list always
zstyle ':completion:*:*:kill:*'    menu yes select
zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
#zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"
#zstyle ':completion:*:processes' command 'ps -au $USER'

zstyle ':completion:*:functions' ignored-patterns '_*' # ignore completion functions for unavailable commands

# ssh known hosts
zstyle -e ':completion::*:*:*:hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/hosts,etc/ssh_,${HOME}/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# man zshcontrib
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' actionformats     '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats           '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
#zstyle ':vcs_info:*' formats           '%{$fg[yellow]%}%c%{$fg[green]%}%u%{$reset_color%} [%{$fg[blue]%}%b%{$reset_color%}] %{$fg[yellow]%}%s%{$reset_color%}:%r'
zstyle ':vcs_info:git:*' branchformat '%b%F{1}:%F{3}%r'
# precmd () { vcs_info } # run before each prompt
#PS1='%F{5}[%F{2}%n%F{5}] %F{3}%3~ ${vcs_info_msg_0_}%f%# '

# completion for kitty
#kitty +complete setup zsh | source /dev/stdin

# completion for dagger
#dagger completion zsh | tee /usr/local/share/zsh/site-functions/_dagger &> /dev/null

# completion for gradle
#source /etc/profiles/per-user/$USER/share/zsh/site-functions/_gradle
#__gradle-completion-init

# completion for kubectl and its alias 'k'
# source: https://michaelheap.com/kubectl-alias-autocomplete/
source <(kubectl completion zsh)
# `kubectl completion zsh` too slow
# source: https://gist.github.com/weltonrodrigo/ad17620e678c7231330aa73043cee8a2
#source <(eval HTTPS_PROXY=1:1 kubectl completion zsh)
compdef k='kubectl'
