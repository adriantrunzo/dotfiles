# dotfiles

My dotfiles, mainly based around vim, git and zsh. From time-to-time I use
mercurial, so I've got some customizations for that as well. For zsh, I use
[oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) with a custom theme in
`.config/zsh`. For vim, I've switched from
[pathogen](https://github.com/tpope/vim-pathogen) to
[vundle](https://github.com/gmarik/vundle) as managing so many git submodules
was getting tedious.

## Usage

I use [GNU Stow](http://www.gnu.org/software/stow/) to manage my dotfiles.
Perhaps later I will need something more complicated.

### Install

    git clone git@github.com:adriantrunzo/dotfiles.git; cd dotfiles
    git submodule init; git submodule update
    bash setup/setup.sh [Computer Name]

Regardless of where you cloned the dotfiles, this install will create symlinks
in your home directory to the appropriate dotfiles.

### Uninstall

This uninstall will just remove the symlinks, any other settings will remain.

    cd /path/to/dotfiles/repository; stow -D . --target ~
