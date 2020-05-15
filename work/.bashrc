# source global bashrc
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# exec fish only if this is a login shell
shopt -q login_shell && exec fish
