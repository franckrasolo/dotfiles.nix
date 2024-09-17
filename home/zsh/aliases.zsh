HELPDIR=$(nix path-info $(which zsh))/share/zsh/$(zsh --version | awk '{ print $2 }')/help

autoload -Uz run-help
autoload -Uz run-help-git
autoload -Uz run-help-sudo

unalias run-help && alias help=run-help

alias abup="antibody bundle < ${ZDOTDIR}/plugins.txt >| ${ZDOTDIR}/plugins.zsh"
alias ff="fastfetch"

alias icat="kitty +kitten icat"
alias img="timg --clear --center --upscale --pixelation=sixel"
alias fd="fd --color=always --no-ignore --hidden"
alias http="xh"
alias https="xhs"
alias fs="yazi"
alias ls="eza --color=always --icons --git"
alias time="/usr/bin/time -p"
alias tree="tree -FpaChlD --du"

alias egrep="egrep --color=always"
alias fgrep="fgrep --color=always"
alias  grep="grep  --color=always"

alias rge='rg --files | sk --preview="bat {} --color=always" --bind "enter:execute(nvim {})"'
alias rgi='sk --interactive --cmd "rg {} --color=always" --ansi'

alias vi="nvim"
alias view="nvim"
alias vim="nvim"
alias vimdiff="nvim -d -O"

# source: https://blog.jpalardy.com/posts/untangling-your-homebrew-dependencies/
alias brew:graph="brew graph --installed --highlight-leaves | fdp -T png -o graph.png"
alias dotfiles="cd ~/dev/dotfiles.nix"

alias gpg:gen-key="gpg --full-gen-key"
alias gpg:secret-keys="gpg --list-secret-keys --keyid-format SHORT"
alias gpg:copy-pubkey='echo "gpg --armor --export <signing_key> | pbcopy"'

alias gradle:daemons="pgrep -fl '.*GradleDaemon.*'"
#alias k9s=$XDG_BIN_HOME/_k9s
alias pkgs='for pkg in $(home-manager packages | cut -d "-" -f 1 | sort -u); do printf "$pkg "; done'
alias q="pueue"

alias j="just"
alias jc="just check"
alias tuple:renice="sudo renice -20 $(pgrep Tuple)"

alias dns:clear_cache="sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias tcp:ports="lsof -Pwni tcp | grep java"

alias luajit="rlwrap luajit"
alias tmux="TERM=xterm-256color tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"
# workaround to help Zellij's session manager plugin load layouts symlinked to the Nix store
# https://github.com/zellij-org/zellij/issues/2764#issuecomment-2057927613
alias z="zellij --layout welcome options --layout-dir $ZELLIJ_CONFIG_DIR/layouts"

alias ht="hn top"
alias hv="hn view --browser"

alias weather="curl http://wttr.in/London"
