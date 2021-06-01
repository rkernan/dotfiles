function fish_user_key_bindings
    fish_hybrid_key_bindings
    if type -q fzf
        fzf_key_bindings
        git_fzf_key_bindings
        hosts_fzf_key_bindings
    end
end
