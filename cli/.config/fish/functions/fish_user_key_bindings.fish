function fish_user_key_bindings
  fish_hybrid_key_bindings

  fzf_key_bindings

  bind \cg\ch _fzf_search_git_log
  bind \cg\cf _fzf_search_git_status

  if bind -M insert &>/dev/null
    bind -M insert \cg\ch _fzf_search_git_log
    bind -M insert \cg\cf _fzf_search_git_status
  end
end
