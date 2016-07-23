ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$HOME/.config/zsh
ZSH_THEME="adriantrunzo"
DISABLE_AUTO_TITLE="true"
plugins=(git github python mercurial osx)

source $ZSH/oh-my-zsh.sh

if [ "$(uname -s)" = "Darwin" -a -f $(brew --prefix)/etc/zsh_completion ]
then
    source $(brew --prefix)/etc/zsh_completion
fi

# Overwrite oh-my-zsh default alias
alias ls="ls -alGFh"

# A most excellent discovery
umask u=rwx,g=rw,o=r
