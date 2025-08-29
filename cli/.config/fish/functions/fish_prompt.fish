function _prompt_jobs
  set -l num_jobs (jobs | wc -l | tr -d '[:space:]')
  if test $num_jobs -gt 0
    string join '' -- (set_color $fish_color_jobs) $num_jobs
  end
end

function _prompt_last_status -a last_status
  if test $last_status -ne 0
    string join '' -- (set_color $fish_color_status) $last_status
  end
end

function _prompt_pwd
  if set -q SSH_CLIENT || set -q SSH_TTY
    string join ' ' -- (prompt_login) ':' (set_color $fish_color_cwd) (prompt_pwd)
  else
    string join ' ' -- (set_color $fish_color_cwd) (prompt_pwd)
  end
end

function _prompt_symbol
  switch (whoami)
    case root
      string join '' -- (set_color normal) '# '
    case '*'
      string join '' -- (set_color normal) '$ '
  end
end

function fish_prompt
  set -l last_status $status
  string join ' ' -- (_prompt_pwd) (_prompt_jobs) (_prompt_last_status $last_status) (_prompt_symbol)
end
