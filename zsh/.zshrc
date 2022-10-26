# Add Homebrew's executable directory to the front of the PATH.
export PATH=/usr/local/lib/ruby/gems/3.0.0/bin:/usr/local/opt/ruby/bin:/usr/local/bin:/usr/local/sbin:$PATH
export BAT_THEME=Dracula
export CLICOLOR=1

# fzf configuration.
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--border --layout=reverse --info=inline --bind=ctrl-j:toggle+down,ctrl-k:toggle+up,tab:down,shift-tab:up'

# nnn configuration. https://github.com/jarun/nnn/wiki/Usage#configuration
export NNN_PLUG='d:fzcd;o:fzopen;r:gitroot'

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

# Load fzf-tab.
[ -d ~/.config/zsh/fzf-tab ] && source ~/.config/zsh/fzf-tab/fzf-tab.plugin.zsh

# Helpful commands for finishing the setup of a new machine.
alias install-brew='/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
alias install-kitty='curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin'
alias install-nnn-plugins='curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh'
alias install-tools='brew install bat fd fzf git nnn ripgrep starship vim'

# Miscellaneous maintenance.
alias update-nnn-plugins='~/.config/nnn/plugins/getplugs'

if type starship &>/dev/null; then
  eval "$(starship init zsh)"
fi
