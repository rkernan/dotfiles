function _fzf_wrapper
	set -lx SHELL (command --search fish)

	if test -z FZF_DEFAULT_OPTS
		set -x FZF_DEFAULT_OPTS '--cycle --layout=reverse --border --height=90% --prompt="'$fzf_prompt'" --pointer="'$fzf_pointer'" --marker="'$fzf_marker'"'
	end

	fzf $argv
end
