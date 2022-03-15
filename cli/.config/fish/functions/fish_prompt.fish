function _prompt_jobs
  set -l num_jobs (jobs | wc -l | tr -d '[:space:]')
  if test $num_jobs -gt 0
    set_color --bold yellow
    echo -n "$num_jobs "
    set_color normal
  end
end

function _prompt_last_pipestatus -a last_pipestatus
  __fish_print_pipestatus "" " " "|" (set_color $fish_color_status) (set_color --bold $fish_color_status) $last_pipestatus
end

function _prompt_virtualenv
  if set -q VIRTUAL_ENV
    set_color blue white
    echo -n '(venv) '
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
  prompt_pwd
  set_color normal
end

function fish_prompt
  set -l last_pipestatus $pipestatus
  echo -n (_prompt_jobs)
  echo -n (_prompt_last_pipestatus $last_pipestatus)
  echo -n (_prompt_virtualenv)
  echo -n (_prompt_hostname)
  echo -n (_prompt_pwd)
  echo -n (fish_vcs_prompt)
  echo -n (set_color --bold white) '>' (set_color normal)
end
