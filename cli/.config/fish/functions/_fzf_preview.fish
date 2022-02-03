function _fzf_preview
	if test (tput cols) -ge 120
		echo --preview="$argv"
	end
end
