autoload -Uz add-zsh-hook

_tuios_osc133_precmd()  { local s=$?; print -n "\e]133;D;$s\a\e]133;A\a"; }
_tuios_osc133_preexec() { print -n "\e]133;C\a"; }

add-zsh-hook precmd _tuios_osc133_precmd
add-zsh-hook preexec _tuios_osc133_preexec

PS1+=$'%{\e]133;B\a%}'
