# source global bashrc
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# exec fish only if this is a login shell
fish_cmd="${HOME}/.linuxbrew/bin/fish"
shopt -q login_shell && [ -e "$fish_cmd" ] && exec $fish_cmd
