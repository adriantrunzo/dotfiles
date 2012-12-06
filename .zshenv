# OS X 10.7 : /usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin
export PATH="/usr/local/bin:/usr/local/share/python:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin"

# homebrew rbenv
# chsh -s /bin/zsh, always a dank move
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export RBENV_ROOT=/usr/local/opt/rbenv
