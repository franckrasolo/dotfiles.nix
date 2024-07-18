export KEYTIMEOUT=1 # shorten shell delay to 10ms for key sequences

bindkey -v # force standard Vi key bindings, regardless of the value of EDITOR

# line navigation
bindkey "^a"  beginning-of-line
bindkey "^e"  end-of-line

autoload -U select-word-style
select-word-style normal
export WORDCHARS="~!#$%^&*(){}[]<>+"

bindkey "^b" backward-word
bindkey "^w" forward-word

bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

# line editing
#bindkey "^[?" backward-kill-word # Ctrl+backspace must send the 'Esc+?' escape sequence
bindkey "^h" backward-kill-word   # Ctrl+Backspace
bindkey "^x"  kill-word
bindkey "^k"  kill-line
bindkey "^u"  backward-kill-line

# source: https://github.com/zegervdv/dotfiles/blob/1dfbc1605e8ef0833f7362cf1813d5767aff7775/dot_zshrc#L349-L352
unix-word-rubout() {
  local WORDCHARS=$'!"#$%&\'()*+,-.:;<=>?@[\\]/^_`{|}~'
  zle backward-kill-word
}
zle -N unix-word-rubout
bindkey "^w" unix-word-rubout

revert-line () {
  while zle .undo; do done
}
zle -N revert-line
bindkey "^y"  revert-line

export FZF_DEFAULT_COMMAND="rg --files --hidden --no-ignore-vcs --no-messages"
export FZF_DEFAULT_OPTS=$(echo $(echo "
  --cycle --extended --layout=reverse --height=80% --preview-window=top:75%:wrap
  --bind=ctrl-j:preview-down,ctrl-k:preview-up,ctrl-n:preview-page-down,ctrl-p:preview-page-up
"))

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# history search with fzf
export FZF_CTRL_R_OPTS="--preview='echo {}' --preview-window=down:3:hidden:wrap --bind '?:toggle-preview' --sort --exact"
export FZF_CTRL_T_OPTS="--preview='(bat --color=always {} || tree -C {}) 2> /dev/null | head -200' --select-1 --exit-0"
export  FZF_ALT_C_OPTS="--preview='tree -C {} | head -200' --select-1 --exit-0"

if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
fi

fzf-history-widget-accept() { fzf-history-widget && zle accept-line }

zle     -N   fzf-history-widget-accept
bindkey "^r" fzf-history-widget-accept

# history search in vi mode
bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down

# use up/down arrows to search through history for previous commands matching everything
# up to the cursor position - moves the cursor to the end of line after each match
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "^[[A" up-line-or-beginning-search   # Up
bindkey "^[[B" down-line-or-beginning-search # Down
