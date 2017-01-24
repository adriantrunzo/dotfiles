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

    # Install git completion
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        source $(brew --prefix)/etc/bash_completion
    fi

    # macOS aliases
    alias ls="ls -AGF"
fi
