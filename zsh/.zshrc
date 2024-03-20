export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH
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
alias install-tools='brew install bun fd fnm git ripgrep starship typescript-language-server vim'

plugins=(
  ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
  ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

  # Private, work-related configuration.
  ~/slice/slice.zsh
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
