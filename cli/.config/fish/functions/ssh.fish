function ssh
	if not test -z $TMUX
		tmux rename-window "$argv"
		command ssh $argv
		tmux set-window-option automatic-rename "on"
	else
		command ssh $argv
	end
end
