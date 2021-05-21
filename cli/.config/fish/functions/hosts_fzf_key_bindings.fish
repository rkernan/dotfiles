function hosts_fzf_key_bindings --description "Set custom keybindings for hosts+fzf"
	bind \ch __hosts_fzf

	if bind -M insert >/dev/null 2>&2
		bind -M insert \ch __hosts_fzf
	end
end
