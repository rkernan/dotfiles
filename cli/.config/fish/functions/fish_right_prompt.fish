function _prompt_git
  set_color $__fish_git_prompt_color_branch
  string join '' -- (fish_git_prompt ' %s')
end

function _prompt_virtualenv
  if set -q VIRTUAL_ENV
    string join '' -- (set_color $fish_color_venv) ' ' (basename "$VIRTUAL_ENV")
  end
end

function fish_right_prompt
  string join ' ' -- (_prompt_git) (_prompt_virtualenv)
  set_color normal
end
