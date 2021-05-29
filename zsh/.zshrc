# Add Homebrew's executable directory to the front of the PATH
export PATH=/usr/local/bin:$PATH
export BAT_THEME=Dracula
export CLICOLOR=1
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

# Load node version manager
eval "$(fnm env)"

# Load Homebrew completions
if type brew &>/dev/null; then
  chmod -R go-w "$(brew --prefix)/share"
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

alias v="nvim"

eval "$(starship init zsh)"
