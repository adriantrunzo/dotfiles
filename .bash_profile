# Load non-login related bash settings
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

source ~/.git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS=1
MY_PROMPT_PREFIX='\[\e[0;33m\]\h\[\e[0m\]:\W'
MY_PROMPT_SUFFIX=' \\$ '
PROMPT_COMMAND='__git_ps1 "$MY_PROMPT_PREFIX" "$MY_PROMPT_SUFFIX"'
