export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH

# bat configuration. https://github.com/sharkdp/bat#customization
export BAT_THEME=Dracula

# https://draculatheme.com/fzf
FZF_COLORS=(
  'fg:#f8f8f2'
  'bg:#282a36'
  'hl:#bd93f9'
  'fg+:#f8f8f2'
  'bg+:#44475a'
  'hl+:#bd93f9'
  'info:#ffb86c'
  'prompt:#50fa7b'
  'pointer:#ff79c6'
  'marker:#ff79c6'
  'spinner:#ffb86c'
  'header:#6272a4'
)

FZF_OPTIONS=(
  '--bind=alt-space:toggle-all,ctrl-a:toggle-all,ctrl-space:toggle'
  '--bind=ctrl-j:preview-down,ctrl-k:preview-up'
  "--color=${(j[,])FZF_COLORS}"
  '--highlight-line'
  '--info=inline'
  '--marker=*'
  '--reverse'
)

BREW_PACKAGES=(
  'bat'
  'fd'
  'fzf'
  'git'
  'lua-language-server'
  'neovim'
  'nnn'
  'oven-sh/bun/bun'
  'pnpm'
  'ripgrep'
  'starship'
  'stylua'
  'tree-sitter-cli'
  'vim'
)

# fzf configuration. https://github.com/junegunn/fzf#settings
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="${(j[ ])FZF_OPTIONS}"

# Use fd to generate the list for file completion.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion.
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# nnn configuration. https://github.com/jarun/nnn/wiki/Usage#configuration
# https://draculatheme.com/nnn
export NNN_FCOLORS="D4DEB778E79F9F67D2E5E5D2"
export NNN_OPTS="Ae"
export NNN_PLUG='d:fzcd;o:fzopen;r:gitroot'

export VISUAL="nvim"

# Load Homebrew completions.
if type brew &>/dev/null; then
  chmod -R go-w "$(brew --prefix)/share"
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

# Load npm completion.
if type npm &>/dev/null; then
  eval "$(npm completion)"
fi

# Load fzf integration.
if type fzf &>/dev/null; then
  eval "$(fzf --zsh)"
fi

# Use Vi bindings.
bindkey -v

# Helpful commands for finishing the setup of a new machine.
alias install-brew='/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
alias install-nnn-plugins='curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh'
alias install-nvm='curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash'
alias install-tools="brew install ${(j[ ])BREW_PACKAGES}"

# Miscellaneous maintenance.
alias update-nnn-plugins='~/.config/nnn/plugins/getplugs'

PLUGINS=(
  ~/.config/zsh/fzf-tab/fzf-tab.plugin.zsh
  ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
  ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

  # Private, work-related configuration.
  ~/slice/slice.zsh
)

for p ($PLUGINS) {
  [ -f $p ] && source $p
}

zstyle ':fzf-tab:*' use-fzf-default-opts yes

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

if type starship &>/dev/null; then
  eval "$(starship init zsh)"
fi
