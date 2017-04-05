#!/bin/bash

cd $(dirname "$0")/..

if [[ $(uname -s) == "Darwin" ]]
then
    bash setup/mac.sh
fi

stow --stow . --target ~
export PATH=/usr/local/bin:$PATH

# install vim bundles
vim +PluginInstall +qall

pip install flake8
pip install virtualenv
pip install virtualenvwrapper
