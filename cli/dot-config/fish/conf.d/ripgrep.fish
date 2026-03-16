if test -n "$XDG_CONFIG_HOME"
  set -x RIPGREP_CONFIG_PATH $XDG_CONFIG_HOME"/ripgrep/config"
else
  set -x RIPGREP_CONFIG_PATH $HOME"/.config/ripgrep/config"
end
