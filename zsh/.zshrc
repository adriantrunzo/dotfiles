# Add Homebrew's executable directory to the front of the PATH
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export BAT_THEME=Dracula
export CLICOLOR=1

# Load node version manager
eval "$(fnm env)"

# Load Homebrew completions
if type brew &>/dev/null; then
  chmod -R go-w "$(brew --prefix)/share"
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

eval "$(starship init zsh)"
