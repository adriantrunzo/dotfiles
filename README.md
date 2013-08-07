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

    git clone git@github.com:adriantrunzo/dotfiles.git ~/dotfiles
    cd dotfiles; stow .

Assuming you cloned the dotfiles into your home directory, this will create
symlinks to the appropriate files there. If you cloned somewhere else, you'll
have to change stow's target.

### Uninstall

    cd dotfiles; stow -D .
