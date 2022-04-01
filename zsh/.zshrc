# Add Homebrew's executable directory to the front of the PATH.
export PATH=/usr/local/lib/ruby/gems/3.0.0/bin:/usr/local/opt/ruby/bin:/usr/local/bin:/usr/local/sbin:$PATH
export BAT_THEME=Dracula
export CLICOLOR=1

# fzf configuration.
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--border --info=inline'

# nnn configuration. https://github.com/jarun/nnn/wiki/Usage#configuration
export NNN_PLUG='d:fzcd;o:fzopen'
export NNN_TRASH=1

# Use fd to generate the list for file completion.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion.
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Load Homebrew completions.
if type brew &>/dev/null; then
  chmod -R go-w "$(brew --prefix)/share"
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

# Use Vi bindings.
bindkey -v

# Load FZF completion. Must come after other bindkey calls.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(starship init zsh)"
