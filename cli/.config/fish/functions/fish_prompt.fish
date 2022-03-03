function fish_prompt
  set -l last_pipestatus $pipestatus

  set -l num_jobs (jobs | wc -l | tr -d '[:space:]')
  if test $num_jobs -gt 0
    echo -n -s (set_color --bold yellow) "$num_jobs" (set_color normal) " "
  end

  echo -n -s (__fish_print_pipestatus "" " " "|" (set_color $fish_color_status) (set_color --bold $fish_color_status) $last_pipestatus)

  if set -q VIRTUAL_ENV
    echo -n -s (set_color blue white) "(venv)" (set_color normal) " "
  end

  if set -q SSH_CLIENT || set -q SSH_TTY
    echo -n -s (set_color $fish_color_host_remote) (prompt_hostname) (set_color normal) ":"
  end

  set -l prompt_suffix
  switch $fish_bind_mode
    case default
      set prompt_suffix $__fish_vi_prompt_default_suffix
    case insert
      set prompt_suffix $__fish_vi_prompt_insert_suffix
    case replace_one
      set prompt_suffix $__fish_vi_prompt_replace_one_suffix
    case replace
      set prompt_suffix $__fish_vi_prompt_replace_suffix
    case visual
      set prompt_suffix $__fish_vi_prompt_visual_suffix
  end

  echo -n -s (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (fish_vcs_prompt) (set_color --bold white) " $prompt_suffix " (set_color normal)
end
