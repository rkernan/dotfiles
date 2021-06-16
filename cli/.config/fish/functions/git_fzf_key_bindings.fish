function git_fzf_key_bindings
    bind \cg\cf __git_fzf_git_status
    bind \cg\cb __git_fzf_git_branch
    bind \cg\ct __git_fzf_git_tag
    bind \cg\ce __git_fzf_git_log
    
    if bind -M insert >/dev/null 2>&1
        bind -M insert \cg\cf __git_fzf_git_status
        bind -M insert \cg\cb __git_fzf_git_branch
        bind -M insert \cg\ct __git_fzf_git_tag
        bind -M insert \cg\ce __git_fzf_git_log
    end
end
