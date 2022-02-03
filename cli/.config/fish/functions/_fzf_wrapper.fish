function _fzf_wrapper
	set -lx SHELL (command --search fish)
	fzf $argv
end
