function _prompt_cmd_duration
  if test $CMD_DURATION -ge 5000
    set_color brwhite
    echo -n ' '(time_conv $CMD_DURATION)' '
    set_color normal
    # only print duration once
    set -g CMD_DURATION 0
  end
end

function fish_right_prompt
  echo -ns \
    (set_color --background $fish_prompt_bg_color) \
    (_prompt_cmd_duration)
end
