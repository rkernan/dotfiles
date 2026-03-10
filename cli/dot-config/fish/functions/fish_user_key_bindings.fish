function fish_user_key_bindings
  fish_hybrid_key_bindings

  fzf --fish | source

  bind ctrl-g,ctrl-h _fzf_search_git_log
  bind ctrl-g,ctrl-f _fzf_search_git_status

  if bind --mode insert &>/dev/null
    bind --mode insert . _expand_dots
    bind --mode insert ! _expand_bang
    bind --mode insert ctrl-g,ctrl-h _fzf_git_log
    bind --mode insert ctrl-g,ctrl-f _fzf_git_status
  end
end
