#!/bin/bash

# http://stackoverflow.com/a/246128
DOTFILES="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NVM_DIR="$HOME/.nvm"

cd "$DOTFILES"

stow --stow . --target ~
export PATH=/usr/local/bin:$PATH

if [[ $(uname -s) == "Darwin" ]]
then
    bash setup/mac.sh
fi

# install vim bundles
vim +PluginInstall +qall

pip install flake8
pip install virtualenv
pip install virtualenvwrapper

git clone https://github.com/creationix/nvm.git "$NVM_DIR"
cd "$NVM_DIR"
git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" origin`
