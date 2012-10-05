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

# OS X 10.7 : /usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin
export PATH="/usr/local/bin:/usr/local/share/python:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin"
