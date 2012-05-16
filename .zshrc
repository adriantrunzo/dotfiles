# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="trunzoa"
DISABLE_AUTO_TITLE="true"
plugins=(git github osx)
source $ZSH/oh-my-zsh.sh

alias ls="ls -GFh"
alias ulcom="ssh ulcom@ultralingua.com"
alias hooper="ssh trunzo@hooper.ultralingua.com"

# Homebrew requires /usr/local/bin beforehand
export PATH="/usr/local/bin:/usr/local/share/python:$PATH"

# Wordnet 
export PATH="/usr/local/WordNet-3.0/bin:$PATH"
