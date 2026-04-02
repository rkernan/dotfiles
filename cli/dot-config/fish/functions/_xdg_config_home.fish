function _xdg_config_home --description "get XDG_CONFIG_HOME or default"
  if test -n "$XDG_CONFIG_HOME"
    printf $XDG_CONFIG_HOME
  else
    printf $HOME"/.config"
  end
end
