export NVM_DIR="$HOME/.nvm"

if type /opt/homebrew/bin/brew &>/dev/null; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

BREW_PACKAGES=(
  'bat'
  'git'
  'lua-language-server'
  'neovim'
  'ripgrep'
  'starship'
  'stylua'
  'tree-sitter-cli'
  'ty'
)

export BAT_THEME=Dracula
export VISUAL="nvim"

# Load npm completion.
if type npm &>/dev/null; then
  eval "$(npm completion)"
fi

# Enable nvm.
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

PLUGINS=(
  $HOME/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
  $HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

  # Private, work-related configuration.
  $HOME/.zshrc.local
)

for p ($PLUGINS) {
  [ -f $p ] && source $p
}

# Enable better Zsh completion.
autoload -Uz compinit
compinit

# Use Vi bindings.
bindkey -v

# Helpful commands for finishing the setup of a new machine.
alias install-brew='/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
alias install-nvm='curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash'
alias install-tools="brew install ${(j[ ])BREW_PACKAGES}"

if type starship &>/dev/null; then
  eval "$(starship init zsh)"
fi
