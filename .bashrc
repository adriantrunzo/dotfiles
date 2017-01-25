## Global settings

alias ll="ls -lA"

export PATH="/usr/local/bin:$PATH"

# Set up python/virtualenvwrapper
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/Code
    export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
    source /usr/local/bin/virtualenvwrapper.sh
fi

## macOS settings
if [ "$(uname -s)" = "Darwin" ]; then
    
    # Homebrew install all bash completions to one directory
    readonly completions_dir=$(brew --prefix)/etc/bash_completion.d

    # If the directory exists, source all of the completion scripts
    # This loop will include git-prompt.sh
    if [ -d $completions_dir ]; then
        for completion in $completions_dir/*; do
            source $completion
        done
    fi

    # macOS aliases
    alias ls="ls -AGF"
fi
