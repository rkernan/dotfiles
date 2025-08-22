function fish_user_key_bindings
  fish_hybrid_key_bindings

  fzf --fish | source

  bind \cg\ch _fzf_search_git_log
  bind \cg\cf _fzf_search_git_status


  if bind --mode insert &>/dev/null
    bind --mode insert \cg\ch _fzf_search_git_log
    bind --mode insert \cg\cf _fzf_search_git_status
    bind --mode insert . _expand_dots
    bind --mode insert ! _expand_bang
  end
end
