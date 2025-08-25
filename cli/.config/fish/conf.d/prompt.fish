status is-interactive || exit

set fish_color_cwd brwhite
set fish_color_host brwhite
set fish_color_host_remote brwhite
set fish_color_user brwhite
set fish_color_status red --bold
set fish_color_jobs yellow --bold
set fish_color_venv cyan

# command colors
set fish_color_command normal
set fish_color_redirection brblack --bold
set fish_color_end brblack --bold
set fish_color_param normal

# git prompt colors and symbols
set -g __fish_git_prompt_show_informative_status true
set -g __fish_git_prompt_color_branch magenta
set -g __fish_git_prompt_color_merging normal
set -g __fish_git_prompt_char_stateseparator ""
set -g __fish_git_prompt_showupstream "informative"
set -g __fish_git_prompt_char_upstream_ahead "↑"
set -g __fish_git_prompt_char_upstream_behind "↓"
set -g __fish_git_prompt_char_upstream_prefix ""
set -g __fish_git_prompt_color_upstream normal
set -g __fish_git_prompt_color_cleanstate green
set -g __fish_git_prompt_char_cleanstate ""
set -g __fish_git_prompt_color_stagedstate green
set -g __fish_git_prompt_char_stagedstate "+"
set -g __fish_git_prompt_color_dirtystate yellow
set -g __fish_git_prompt_char_dirtystate "+"
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_char_invalidstate "⨯"
set -g __fish_git_prompt_color_untrackedfiles red
set -g __fish_git_prompt_char_untrackedfiles "…"
