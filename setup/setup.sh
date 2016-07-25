#!/bin/bash

cd $(dirname "$0")/..

if [[ $(uname -s) == "Darwin" ]]
then
    bash setup/mac.sh
fi

git submodule init; git submodule update
stow --stow . --target ~
export PATH=/usr/local/bin:$PATH

# install vim bundles
vim +PluginInstall +qall

pip install flake8
pip install virtualenv
pip install virtualenvwrapper

# Switch login shell to zsh
chsh -s /bin/zsh $(whoami)
