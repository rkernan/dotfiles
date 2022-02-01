function __fzf_hosts -d "Fuzzy select hosts"
	set -l fzf_hosts_file ~/.hosts
	set -l fzf_hosts_command "cat $fzf_hosts_file 2> /dev/null | grep -v '^#' | column -t"

	eval $fzf_hosts_command | eval (__fzfcmd)' -m' | awk '{print $1}' |
		while read -l r
			set result $result (string escape $r)
		end

	commandline -it -- (string join ' ' $result)
	commandline -f repaint
end
