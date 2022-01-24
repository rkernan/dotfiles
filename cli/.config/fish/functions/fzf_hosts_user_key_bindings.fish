function fzf_hosts_user_key_bindings -d "Set custom keybindings for hosts+fzf"
	bind \ch __fzf_hosts

	if bind -M insert >/dev/null 2>&2
		bind -M insert \ch __fzf_hosts
	end
end
