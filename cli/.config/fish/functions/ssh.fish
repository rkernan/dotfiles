function ssh
	if not test -z $TMUX
		set -l orig (tmux display-message -p '#W')
		tmux rename-window "$argv"
		command ssh $argv
		tmux rename-window "$orig"
		tmux set-window-option automatic-rename "on"
	else
		command ssh $argv
	end
end
