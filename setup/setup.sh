#!/bin/bash
set -e

cd $(dirname "$0")/..

if [[ $(uname -s) == "Darwin" ]]
then
    bash setup/mac.sh $1
fi

stow --stow . --target ~
export PATH=/usr/local/bin:$PATH

# install vim bundles
vim +BundleInstall +qall

pip install flake8
pip install virtualenv

# Switch login shell to zsh
chsh -s /bin/zsh $(whoami)

if [[ $(uname -s) == "Darwin" ]]
then
    # Copy patched font into place
    cp ~/.fonts/*.otf ~/Library/Fonts/

    # Open solarized theme so we can set as Default later
    curl --silent  https://raw.github.com/tomislav/osx-terminal.app-colors-solarized/master/Solarized%20Dark.terminal --output "Solarized Dark.terminal"
    open "Solarized Dark.terminal"
    mv "Solarized Dark.terminal" ~/.Trash
fi

