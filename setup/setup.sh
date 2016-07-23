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
vim +BundleInstall +qall

pip install flake8
pip install virtualenv
pip install virtualenvwrapper

# Switch login shell to zsh
chsh -s /bin/zsh $(whoami)

if [[ $(uname -s) == "Darwin" ]]
then
    # Open solarized theme so we can set as Default later
    curl --silent  https://raw.github.com/tomislav/osx-terminal.app-colors-solarized/master/Solarized%20Dark.terminal --output "Solarized Dark.terminal"
    open "Solarized Dark.terminal"
    mv "Solarized Dark.terminal" ~/.Trash

    read -p "Edit your terminal preferences, then hit any key to restart." -n1 -s
    sudo shutdown -r now
fi

