ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$HOME/.config/zsh
ZSH_THEME="adriantrunzo"
DISABLE_AUTO_TITLE="true"
plugins=(git github mercurial python osx)

source $ZSH/oh-my-zsh.sh

# Overwrite oh-my-zsh default alias
alias ls="ls -alGFh"

# A most excellent discovery
umask u=rwx,g=rw,o=r
