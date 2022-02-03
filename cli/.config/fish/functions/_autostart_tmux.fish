function _autostart_tmux
	if set -q AUTOSTART_TMUX
	and test $AUTOSTART_TMUX -gt 0
	and type -q tmux
	and status is-interactive
	and test -z "$TMUX"
		set --local session 0

		if not tmux has-session -t $session
			tmux new-session -s $session
		end
		exec tmux attach-session -t $session
	end
end
