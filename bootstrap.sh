#!/bin/zsh

# This bootstrap script adapted from Mathias Bynens:
# https://github.com/mathiasbynens/dotfiles


cd "$(dirname "$0")"

FILES=".gitignore-global .gitconfig .hgrc .vim .vimrc .zshrc .oh-my-zsh .mercurial"

# Pull latest changes
git pull

# Mercurial extensions
mkdir .mercurial

hg clone https://bitbucket.org/runeh/identities .mercurial/hg-identities
hg clone https://bitbucket.org/sjl/hg-prompt .mercurial/hg-prompt
hg clone https://developers.kilnhg.com/Code/Kiln/Group/Kiln-Extensions .mercurial/kiln-extensions

# Create Links
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
