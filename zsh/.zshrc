CONFIG="$HOME/.config"

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

PLUGINS=(
  $CONFIG/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
  $CONFIG/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

  # Private, work-related configuration.
  $HOME/.zshrc.local
)

export BAT_THEME=Dracula
export NVM_DIR="$HOME/.nvm"
export RIPGREP_CONFIG_PATH="$CONFIG/ripgrep/config"
export VISUAL="nvim"

# Enable better Zsh completion.
autoload -Uz compinit
compinit

# Use Vi bindings.
bindkey -v

# Initialize Homebrew.
if type /opt/homebrew/bin/brew &>/dev/null; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Enable nvm.
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Load npm completion.
if type npm &>/dev/null; then
  eval "$(npm completion)"
fi

# Load plugins.
for p ($PLUGINS) {
  [ -f $p ] && source $p
}

# Helpful commands for finishing the setup of a new machine.
alias install-brew='/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
alias install-nvm='curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash'
alias install-tools="brew install ${(j[ ])BREW_PACKAGES}"

if type starship &>/dev/null; then
  eval "$(starship init zsh)"
fi
