function _fzf_search_git_status
  if ! __fish_is_git_repository
    return
  end

  git -c color.status=always status --short | _fzf_wrapper --prompt='GitStatus> ' --preview='git diff --color HEAD -- {-1}' --query=(commandline -t) -m --ansi |
    while read -l r
      set -l split (string split --no-empty ' ' $r)
      if test (count $split) -eq 4
      and test "$split[3]" = "->"
        # moved: <STATUS> <NAME> -> <NEW_NAME>
        set -f result $result (string escape $split[4])
      else
        set -f result $result (string escape $split[2])
      end
    end

  commandline -rt -- (string join ' ' $result)
  commandline -f repaint
end
