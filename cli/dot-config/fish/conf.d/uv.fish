function __fish_uv_run_completions
  if set -q VIRTUAL_ENV
    and test -d "$VIRTUAL_ENV/bin"
    ls -1 "$VIRTUAL_ENV/bin"
  end
end

complete -c uv -n '__fish_seen_subcommand_from run; and __fish_is_nth_token 2' -a '(__fish_uv_run_completions)'

function auto_virtualenv --on-event fish_prompt
  set -f virtual_env (find_upwards ".venv")
  set -f activate $virtual_env"/bin/activate.fish"
  if path is $activate
    if set -q VIRTUAL_ENV
      if test $VIRTUAL_ENV = $virtual_env
        return
      else
        deactivate
      end
    end
    VIRTUAL_ENV_DISABLE_PROMPT=1 source $activate
  else if set -q VIRTUAL_ENV
    deactivate
  end
end
