status is-interactive || exit

# command colors
set fish_color_command normal
set fish_color_redirection brblack --bold
set fish_color_end brblack --bold
set fish_color_param normal

# git prompt colors and symbols
set -g __fish_git_prompt_show_informative_status true
set -g __fish_git_prompt_color_branch magenta
set -g __fish_git_prompt_showupstream "informative"
set -g __fish_git_prompt_char_upstream_prefix ""
set -g __fish_git_prompt_color_cleanstate green
set -g __fish_git_prompt_color_stagedstate green
set -g __fish_git_prompt_color_dirtystate yellow
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_untrackedfiles red
set -g __fish_git_prompt_char_upstream_ahead "↑"
set -g __fish_git_prompt_char_upstream_behind "↓"
set -g __fish_git_prompt_char_cleanstate ""
set -g __fish_git_prompt_char_stagedstate "•"
set -g __fish_git_prompt_char_dirtystate "+"
set -g __fish_git_prompt_char_invalidstate "⨯"
set -g __fish_git_prompt_char_untrackedfiles "…"
