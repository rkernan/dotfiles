function _prompt_jobs
  set -l num_jobs (jobs | wc -l | tr -d '[:space:]')
  if test $num_jobs -gt 0
    set_color --bold $fish_prompt_color_jobs
    echo -n "$num_jobs "
  end
end

function _prompt_last_pipestatus -a last_pipestatus
  __fish_print_pipestatus '' ' ' '|' (set_color red) (set_color --bold red) $last_pipestatus
end

function _prompt_git
  set_color $__fish_git_prompt_color_branch
  echo -ns (fish_git_prompt ' %s ')
end

function _prompt_virtualenv
  if set -q VIRTUAL_ENV
    set_color $fish_prompt_color_venv
    echo -n ' '(basename "$VIRTUAL_ENV")' '
  end
end

function _prompt_hostname
  if set -q SSH_CLIENT || set -q SSH_TTY
    set_color $fish_color_host_remote
    prompt_hostname
    echo -n ':'
  end
end

function _prompt_pwd
  set_color $fish_prompt_color_pwd
  echo -n (prompt_pwd)
end

function fish_prompt
  set -l last_pipestatus $pipestatus
  echo -s                                          \
    '┌─ '                                            \
    (_prompt_jobs)                                 \
    (_prompt_last_pipestatus $last_pipestatus)     \
    (_prompt_git)                                  \
    (_prompt_virtualenv)                           \
    (_prompt_hostname)                             \
    (_prompt_pwd)
  echo -s '└→ ' (set_color normal)
end
