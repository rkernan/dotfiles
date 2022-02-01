function __fzfcmd_with_preview -d "FZF command plus with preview (when screen is big enough)"
	if test (tput cols) -ge 120
		set -l fzf_preview $argv' | head -'(math (tput lines) - 2)
		echo (__fzfcmd)' --preview="'$fzf_preview'"'
	else
		__fzfcmd
	end
end
