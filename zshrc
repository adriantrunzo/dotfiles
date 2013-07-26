# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="adriantrunzo"
DISABLE_AUTO_TITLE="true"
plugins=(git github osx)
source $ZSH/oh-my-zsh.sh

alias ls="ls -GFh"

# Need to use vim compiled against system python
alias vim="/usr/local/bin/vim"

# A most excellent discovery
umask u=rwx,g=rw,o=r
