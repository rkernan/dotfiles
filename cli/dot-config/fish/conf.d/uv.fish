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
