# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
DISABLE_AUTO_TITLE="true"
plugins=(git github osx)
source $ZSH/oh-my-zsh.sh

alias ls="ls -GFh"

# Homebrew requires /usr/local/bin beforehand
export PATH="/usr/local/bin:/usr/local/share/python:$PATH"
