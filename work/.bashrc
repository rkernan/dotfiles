# source global bashrc
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# exec fish only if this is a login shell
fish_cmd="${HOME}/.linuxbrew/bin/fish"
if shopt -q login_shell && [ -e "$fish_cmd" ]; then
  export SHELL="$fish_cmd"
  exec $fish_cmd --login
fi
