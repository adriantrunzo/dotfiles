#!/bin/bash
set -e

cd $(dirname "$0")/..

if [[ $(uname -s) == "Darwin" ]]
then
    bash setup/mac.sh
fi

stow --stow . --target ~

# install vim bundles
vim -u ~/.bundles.vim +BundleInstall +q +q

pip install pyflakes

# Switch login shell to zsh
chsh -s /bin/zsh `whoami`

if [[ $(uname -s) == "Darwin" ]]
then
    # Copy patched font into place
    cp ~/.fonts/*.otf ~/Library/Fonts/
fi

