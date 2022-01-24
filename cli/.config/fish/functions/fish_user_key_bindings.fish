function fish_user_key_bindings
    fish_hybrid_key_bindings
    fzf_git_user_key_bindings
    fzf_hosts_user_key_bindings

    if type -q fzf_user_key_bindings
        fzf_user_key_bindings
    end
end
