function _fzf_file_preview
	set -l path $argv

	if test -z "$FZF_FILE_PREVIEW_COMMAND"
		if type -q bat
			set -x FZF_FILE_PREVIEW_COMMAND "bat --style=numbers --color=always --line-range :500 \$path"
		else
			set -x FZF_FILE_PREVIEW_COMMAND "head -500 \$path"
		end
	end

	eval $FZF_FILE_PREVIEW_COMMAND
end
