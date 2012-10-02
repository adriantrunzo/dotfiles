#!/bin/zsh

# This bootstrap script adapted from Mathias Bynens:
# https://github.com/mathiasbynens/dotfiles

# TODO manage mercurial extensions here

cd "$(dirname "$0")"

FILES=".gitignore-global .gitconfig .hgrc .vim .vimrc .zshrc .oh-my-zsh"

# Pull latest changes
git pull

function install() {
    for file in $FILES; do
        ln -sf $file ~/$file
    done
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
    install 
else
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
       install 
    fi
fi

unset install
source ~/.zshrc
