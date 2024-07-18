export CLICOLOR=true

# customise 'grep' highlighting using:
# - https://dom.hastin.gs/files/grep-colors/
# - https://dom111.github.io/grep-colors/

#export GREP_COLORS="sl=49;38;5;71:cx=49;39:mt=48;5;28;97:fn=49;38;5;32:ln=49;38;5;71:bn=49;38;5;241;2;3:se=49;38;5;241"
export GREP_COLORS="sl=49;38;5;71:cx=49;38;5;248;2;3:mt=48;5;199;97;1:fn=49;38;5;71:ln=49;38;5;199;1:bn=49;38;5;143;3:se=49;38;5;246;2"

# for macOS/BSD ls
export LSCOLORS="exfxcxdxbxegedabagacad"

# for GNU/Linux ls
#export LS_COLORS='di=0;34:ln=0;35:so=0;312:pi=0;33:ex=0;31:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'
export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:*.err=38;5;160;1:*.error=38;5;160;1:*.stderr=38;5;160;1:"
#export LS_COLORS="$(vivid generate snazzy)"

alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
alias  grep="grep  --color=auto"

#export DYLD_INSERT_LIBRARIES="$(nix-build '<nixpkgs>' --no-build-output -A stderred)/lib/libstderred.dylib${DYLD_INSERT_LIBRARIES:+:$DYLD_INSERT_LIBRARIES}"
#export DYLD_INSERT_LIBRARIES="$(nix path-info 'nixpkgs#stderred')/lib/libstderred.dylib${DYLD_INSERT_LIBRARIES:+:$DYLD_INSERT_LIBRARIES}"

#export DYLD_INSERT_LIBRARIES="/nix/store/7bfnc1xiqcfl15x664h7sx5kd62cn34h-stderred-unstable-2021-04-28/lib/libstderred.dylib${DYLD_INSERT_LIBRARIES:+:$DYLD_INSERT_LIBRARIES}"

bold=$(tput bold || tput md)
red=$(tput setaf 1)
export STDERRED_ESC_CODE=$(echo -e "$bold$red")
