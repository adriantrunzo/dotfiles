# Load non-login related bash settings
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

MY_PROMPT_PREFIX='\[\e[0;31m\]\h\[\e[0m\]:\W'
MY_PROMPT_SUFFIX=' \\$ '

PS1="$MY_PROMPT_PREFIX$MY_PROMPT_SUFFIX"

# Load git prompt if it is installed and add it to the prompt
if [ -f ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh

    # Settings for git output
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=1
    GIT_PS1_SHOWUPSTREAM="auto"
    GIT_PS1_SHOWCOLORHINTS=1

    # Overwrite the prompt command
    PROMPT_COMMAND='__git_ps1 "$MY_PROMPT_PREFIX" "$MY_PROMPT_SUFFIX"'
fi
