# Add Homebrew's executable directory to the front of the PATH.
export PATH=/usr/local/lib/ruby/gems/3.0.0/bin:/usr/local/opt/ruby/bin:/usr/local/bin:/usr/local/sbin:$PATH

# nnn configuration. https://github.com/jarun/nnn/wiki/Usage#configuration
export NNN_OPTS="Ae"
export NNN_PLUG='r:gitroot'

export VISUAL="vim"

# Load Homebrew completions.
if type brew &>/dev/null; then
  chmod -R go-w "$(brew --prefix)/share"
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

# Use Vi bindings.
bindkey -v

# Helpful commands for finishing the setup of a new machine.
alias install-brew='/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
alias install-kitty='curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin'
alias install-nnn-plugins='curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh'
alias install-tools='brew install fnm fzf git nnn ripgrep starship vim'

# Miscellaneous maintenance.
alias update-nnn-plugins='~/.config/nnn/plugins/getplugs'

plugins=(
  ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
  ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
)

for p ($plugins) {
  [ -f $p ] && source $p
}

if type fnm &>/dev/null; then
  eval "$(fnm env --use-on-cd)"
fi

if type starship &>/dev/null; then
  eval "$(starship init zsh)"
fi
