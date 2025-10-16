function fish_user_key_bindings
  fish_hybrid_key_bindings

  bind ctrl-r _fzy_history
  bind ctrl-t _fzy_files
  bind alt-c _fzy_dirs
  bind ctrl-g,ctrl-h _fzy_git_log
  bind ctrl-g,ctrl-f _fzy_git_status

  if bind --mode insert &>/dev/null
    bind --mode insert . _expand_dots
    bind --mode insert ! _expand_bang
    bind --mode insert ctrl-r _fzy_history
    bind --mode insert ctrl-t _fzy_files
    bind --mode insert alt-c _fzy_dirs
    bind --mode insert ctrl-g,ctrl-h _fzy_git_log
    bind --mode insert ctrl-g,ctrl-f _fzy_git_status
  end
end
