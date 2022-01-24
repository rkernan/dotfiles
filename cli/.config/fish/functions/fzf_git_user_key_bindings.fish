function fzf_git_user_key_bindings
    bind \cg\cf __fzf_git_status
    bind \cg\cb __fzf_git_branch
    bind \cg\ct __fzf_git_tag
    bind \cg\ch __fzf_git_log
    
    if bind -M insert >/dev/null 2>&1
        bind -M insert \cg\cf __fzf_git_status
        bind -M insert \cg\cb __fzf_git_branch
        bind -M insert \cg\ct __fzf_git_tag
        bind -M insert \cg\ch __fzf_git_log
    end
end
