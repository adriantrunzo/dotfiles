# dotfiles

My dotfiles, mainly based around vim, git and bash. Nothing too exciting here,
but please feel free to copy anything if you find it useful.

## Usage

I use [GNU Stow](http://www.gnu.org/software/stow/) to manage my dotfiles.
Perhaps later I will need something more complicated.

### Install

    git clone https://github.com/adriantrunzo/dotfiles.git
    cd dotfiles
    bash setup/setup.sh

Regardless of where you cloned the dotfiles, this install will create symlinks
in your home directory to the appropriate dotfiles.

### Uninstall

This uninstall will just remove the symlinks, any other settings will remain.

    cd /path/to/dotfiles/repository; stow -D . --target ~
