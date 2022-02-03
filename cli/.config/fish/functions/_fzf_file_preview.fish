function _fzf_file_preview

	function echo_red
		set_color red
		echo $argv
		set_color normal
	end

	function echo_yellow
		set_color yellow
		echo $argv
		set_color normal
	end

	set -l path $argv

	if test -L "$path"
		set -l target (realpath $path)
		echo_yellow "'$path' -> '$target'"
		_fzf_file_preview "$target"
	else if test -f "$path" # file
		# TODO config?
		bat --style=numbers --color=always --line-range :500 "$path"
	else if test -d "$path"
		# TODO config?
		command ls -1AF
	else if test -c "$path"
		echo_red "character device"
	else if test -b "$path"
		echo_red "block device"
	else if test -S "$path"
		echo_red "socket"
	else if test -p "$path"
		echo_red "named pipe"
	else
		echo "'$path' doesn't exist..." >&2
	end
end
