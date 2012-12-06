# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="trunzoa"
DISABLE_AUTO_TITLE="true"
plugins=(git github osx)
source $ZSH/oh-my-zsh.sh

alias ls="ls -GFh"
alias qs3304="ssh ultralingua@qs3304.pair.com"
alias hooper="ssh trunzo@hooper.ultralingua.com"
alias ernie="ssh trunzo@ernie.ultralingua.com"

# A most excellent discovery
umask u=rwx,g=rw,o=r
