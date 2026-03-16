set -l brew_prefix /home/linuxbrew/.linuxbrew
if test -d $brew_prefix
  fish_add_path $brew_prefix"/sbin"
  fish_add_path $brew_prefix"/bin"
  # completions
  set -gx fish_complete_path $fish_complete_path $brew_prefix"/share/fish/completions"
  set -gx fish_complete_path $fish_complete_path $brew_prefix"/share/fish/vendor_completions.d"
end
