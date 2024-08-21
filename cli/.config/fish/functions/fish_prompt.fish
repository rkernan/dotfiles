function _prompt_jobs
  set -l num_jobs (jobs | wc -l | tr -d '[:space:]')
  if test $num_jobs -gt 0
    set_color --bold $fish_color_jobs
    echo -n "$num_jobs "
    set_color normal
  end
end

function _prompt_last_pipestatus -a last_pipestatus
  __fish_print_pipestatus "" " " "|" (set_color $fish_color_status) (set_color --bold $fish_color_status) $last_pipestatus
end

function _prompt_git
  set_color $__fish_git_prompt_color_branch
  echo -ns (fish_git_prompt ' %s ')
  set_color normal
end

function _prompt_virtualenv
  if set -q VIRTUAL_ENV
    set_color $fish_color_venv
    echo -n ' '(basename "$VIRTUAL_ENV")' '
    set_color normal
  end
end

function _prompt_hostname
  if set -q SSH_CLIENT || set -q SSH_TTY
    set_color $fish_color_host_remote
    prompt_hostname
    set_color normal
    echo -n ':'
  end
end

function _prompt_pwd
  set_color $fish_color_cwd
  echo -n ' '
  prompt_pwd
  set_color normal
end

function _prompt_mode
  set_color $fish_color_mode
  switch $fish_bind_mode
    case default
      echo ' < '
    case insert
      echo ' > '
    case replace_one
      echo ' > '
    case replace
      echo ' < '
    case visual
      echo ' < '
  end
  set_color normal
end

function fish_prompt
  set -l last_pipestatus $pipestatus
  echo -ns (_prompt_jobs)
  echo -ns (_prompt_last_pipestatus $last_pipestatus)
  echo -ns (_prompt_git)
  echo -ns (_prompt_virtualenv)
  echo -ns (_prompt_hostname)
  echo -ns (_prompt_pwd)
  echo -ns (_prompt_mode)
end
