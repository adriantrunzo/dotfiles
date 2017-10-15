## Global settings

alias ll="ls -lA"

export PATH="/usr/local/bin:$PATH"

# Set up nvm for node installs
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    source "$NVM_DIR/nvm.sh"
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
