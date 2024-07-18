setopt AUTO_CD                # if command is a path, cd into it
setopt AUTO_PUSHD             # make cd push the old directory onto the directory stack
setopt PUSHD_IGNORE_DUPS      # prevent duplicates in the directory stack
setopt PUSHD_SILENT           # do not print the directory stack after pushd or popd
setopt PUSHD_TO_HOME          # pushd = pushd $HOME

HISTFILE=$XDG_DATA_HOME/zsh/history
HISTSIZE=10000                # number of entries to keep in memory for the current session
SAVEHIST=$HISTSIZE            # number of entries to write to the history file
HISTDUP=erase                 # erase duplicates in the history file

setopt APPEND_HISTORY         # allow multiple terminal sessions to all append to one zsh command history
setopt EXTENDED_HISTORY       # save timestamp and runtime information in the ":start:elapsed;command" format
setopt INC_APPEND_HISTORY     # write commands to the history file immediately, not when the shell exits
setopt HIST_EXPIRE_DUPS_FIRST # expire the oldest duplicate entries first when trimming history
setopt HIST_IGNORE_DUPS       # do not record an entry that is already in the history
setopt HIST_IGNORE_ALL_DUPS   # delete old recorded entries if a new entry is a duplicate
setopt HIST_IGNORE_SPACE      # do not record an entry starting with a space
setopt HIST_SAVE_NO_DUPS      # do not write duplicate entries to the history file
setopt HIST_FIND_NO_DUPS      # when searching the history, do not display results already cycled through twice
setopt HIST_REDUCE_BLANKS     # remove superfluous blanks before recording an entry
setopt HIST_VERIFY            # do not execute immediately upon history expansion
setopt SHARE_HISTORY          # share history between all sessions
setopt HIST_FCNTL_LOCK        # call the native fcntl system call to lock the history file on save

setopt AUTO_LIST              # automatically list choices on ambiguous completion
setopt AUTO_MENU              # show the completion menu on successive tab presses - needs unsetop MENU_COMPLETE to work
unsetopt MENU_COMPLETE        # do not autoselect the first completion entry

setopt ALWAYS_TO_END          # when completing from the middle of a word, move the cursor to the end of the word
unsetopt COMPLETE_ALIASES     # allows autocompletion of command line switches for aliases
setopt COMPLETE_IN_WORD       # allow completion from within a word/phrase
setopt CORRECT                # enable spelling correction for commands
unsetopt CORRECT_ALL          # disable spelling correction for arguments
setopt LIST_AMBIGUOUS         # complete as much of a completion until it gets ambiguous

#setopt DOTGLOB                # include filenames beginning with a '.'  in the results of pathname expansion
#setopt GLOB_DOTS              # include dotfiles in globbing
setopt EXTENDED_GLOB          # activate complex pattern globbing
setopt INTERACTIVE_COMMENTS   # allow comments even in interactive shells

setopt LOCAL_OPTIONS          # allow functions to have local options
setopt LOCAL_TRAPS            # allow functions to have local traps

setopt IGNORE_EOF             # disable ^D for exiting the shell, type exit or logout instead
#setopt PRINT_EXIT_VALUE       # print return value if non-zero
setopt PROMPT_SUBST           # enable parameter expansion, command substitution, and arithmetic expansion in the prompt

unsetopt BEEP                 # no bell on error
unsetopt BG_NICE              # no lower priority for background tasks
unsetopt CLOBBER              # prevent the accidental overwriting of an existing file, use >| instead
unsetopt HIST_BEEP            # do not beep on error when accessing the shell history
unsetopt HUP                  # do not emit a hup signal when exiting the shell
unsetopt LIST_BEEP            # no bell on ambiguous completion
unsetopt RM_STAR_SILENT       # ask for confirmation for 'rm *' or 'rm path/*'

# see https://zsh.sourceforge.io/FAQ/zshfaq03.html#l18
setopt SH_WORD_SPLIT          # related to zsh splitting '--dry-run=client --output=yaml'
                              # as '--dry-run' and 'client --output=yaml'
                              # instead of '--dry-run=client' and '--output=yaml'
