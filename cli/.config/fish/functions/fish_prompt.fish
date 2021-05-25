function fish_prompt -d "Write out the prompt"
    set -l last_pipestatus $pipestatus

    set -g __fish_git_prompt_show_informative_status 1
    set -g __fish_git_prompt_color_branch magenta --bold
    set -g __fish_git_prompt_showupstream "informative"
    set -g __fish_git_prompt_char_upstream_prefix ""
    set -g __fish_git_prompt_color_cleanstate green --bold
    set -g __fish_git_prompt_color_stagedstate green
    set -g __fish_git_prompt_color_dirtystate yellow
    set -g __fish_git_prompt_color_invalidstate red
    set -g __fish_git_prompt_color_untrackedfiles red

    if set -q NO_UNICODE
    and test $NO_UNICODE -gt 0
        set -g __fish_git_prompt_char_upstream_ahead "↑"
        set -g __fish_git_prompt_char_upstream_behind "↓"
        set -g __fish_git_prompt_char_cleanstate "!"
        set -g __fish_git_prompt_char_stagedstate "+"
        set -g __fish_git_prompt_char_dirtystate "+"
        set -g __fish_git_prompt_char_invalidstate "x"
        set -g __fish_git_prompt_char_untrackedfiles "??"

        set -g __fish_vi_prompt_default_suffix "<"
        set -g __fish_vi_prompt_insert_suffix ">"
        set -g __fish_vi_prompt_replace_one_suffix "<"
        set -g __fish_vi_prompt_replace_suffix "<"
        set -g __fish_vi_prompt_visual_suffix "<"
    else
        set -g __fish_git_prompt_char_upstream_ahead "↑"
        set -g __fish_git_prompt_char_upstream_behind "↓"
        set -g __fish_git_prompt_char_cleanstate "✓"
        set -g __fish_git_prompt_char_stagedstate "·"
        set -g __fish_git_prompt_char_dirtystate "+"
        set -g __fish_git_prompt_char_invalidstate "⨯"
        set -g __fish_git_prompt_char_untrackedfiles "…"

        set -g __fish_vi_prompt_default_suffix "❮"
        set -g __fish_vi_prompt_insert_suffix "❯"
        set -g __fish_vi_prompt_replace_one_suffix "❮"
        set -g __fish_vi_prompt_replace_suffix "❮"
        set -g __fish_vi_prompt_visual_suffix "❮"
    end

    set -l num_jobs (jobs | wc -l | tr -d '[:space:]')
    if test $num_jobs -gt 0
        echo -n (set_color --bold yellow)$num_jobs" "(set_color normal)
    end

    echo -n (__fish_print_pipestatus "" " " "|" (set_color $fish_color_status) (set_color --bold $fish_color_status) $last_pipestatus)(set_color normal)

    if set -q SSH_CLIENT || set -q SSH_TTY
        echo -n (set_color $fish_color_host_remote)(prompt_hostname)(set_color normal)":"(set_color normal)
    end

    echo -n (set_color $fish_color_cwd)(prompt_pwd)(set_color normal)

    echo -n (set_color normal)(fish_vcs_prompt)(set_color normal)

    set -l prompt_suffix
    switch $fish_bind_mode
        case default
            set prompt_suffix $__fish_vi_prompt_default_suffix
        case insert
            set prompt_suffix $__fish_vi_prompt_insert_suffix
        case replace_one
            set prompt_suffix $__fish_vi_prompt_replace_one_suffix
        case replace
            set prompt_suffix $__fish_vi_prompt_replace_suffix
        case visual
            set prompt_suffix $__fish_vi_prompt_visual_suffix
    end

    echo -n (set_color normal)" $prompt_suffix "(set_color normal)
end
