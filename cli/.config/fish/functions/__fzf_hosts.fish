function __fzf_hosts -d "Fuzzy select hosts"
	set -l res (cat ~/.hosts | grep -v "^#" | column -t | fzf | awk '{print $1}')

	if test -z "$res"
		return 1
	end

	commandline -i -- (printf '%s' $res)
	commandline -f repaint
end
