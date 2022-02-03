function _fzf_search_git_status
  if ! __fish_is_git_repository
    return
  end

  git -c color.status=always status --short | _fzf_wrapper (_fzf_preview 'git diff --color HEAD -- {-1}') --query=(commandline -t) -m --ansi | awk '{print $2}' |
    while read -l r
      set result $result (string escape $r)
    end

  commandline -rt -- (string join ' ' $result)
  commandline -f repaint
end
