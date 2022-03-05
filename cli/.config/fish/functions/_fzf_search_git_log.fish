function _fzf_search_git_log
  if ! __fish_is_git_repository
    return
  end

  git log --color | _fzf_wrapper --prompt='Commits> ' --preview='git show --color {1}' --query=(commandline -t) -m --ansi | awk '{print $1}' |
    while read -l r
      set result $result (git rev-parse (string escape $r))
    end

  commandline -rt -- (string join ' ' $result)
  commandline -f repaint
end
