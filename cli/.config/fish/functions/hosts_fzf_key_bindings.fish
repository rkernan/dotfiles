function hosts_fzf_key_bindings -d "Set custom keybindings for hosts+fzf"
	bind \cs __hosts_fzf

	if bind -M insert >/dev/null 2>&2
		bind -M insert \cs __hosts_fzf
	end
end
