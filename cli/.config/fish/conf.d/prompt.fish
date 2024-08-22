status is-interactive || exit

set fish_prompt_bg_color 3E3E3E

set fish_prompt_color_pwd normal --background $fish_prompt_bg_color
set fish_prompt_color_venv cyan --background $fish_prompt_bg_color
set fish_prompt_color_jobs yellow --background $fish_prompt_bg_color

# command colors
set fish_color_command normal
set fish_color_redirection brblack --bold
set fish_color_end brblack --bold
set fish_color_param normal

# git prompt colors and symbols
set -g __fish_git_prompt_show_informative_status true
set -g __fish_git_prompt_color_branch magenta --background $fish_prompt_bg_color
set -g __fish_git_prompt_color_merging normal --background $fish_prompt_bg_color
set -g __fish_git_prompt_char_stateseparator ""
set -g __fish_git_prompt_showupstream "informative"
set -g __fish_git_prompt_char_upstream_ahead "↑"
set -g __fish_git_prompt_char_upstream_behind "↓"
set -g __fish_git_prompt_char_upstream_prefix ""
set -g __fish_git_prompt_color_upstream normal --background $fish_prompt_bg_color
set -g __fish_git_prompt_color_cleanstate green --background $fish_prompt_bg_color
set -g __fish_git_prompt_char_cleanstate ""
set -g __fish_git_prompt_color_stagedstate green --background $fish_prompt_bg_color
set -g __fish_git_prompt_char_stagedstate "+"
set -g __fish_git_prompt_color_dirtystate yellow --background $fish_prompt_bg_color
set -g __fish_git_prompt_char_dirtystate "+"
set -g __fish_git_prompt_color_invalidstate red --background $fish_prompt_bg_color
set -g __fish_git_prompt_char_invalidstate "⨯"
set -g __fish_git_prompt_color_untrackedfiles red --background $fish_prompt_bg_color
set -g __fish_git_prompt_char_untrackedfiles "…"
