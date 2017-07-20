#
# Prompt
#

autoload -Uz colors && colors
autoload -Uz vcs_info

function precmd {
	vcs_info
}

setopt prompt_subst

# completion indicator
zstyle ':config:editor:completing' format '...'

# editor_info
zstyle ':config:editor:keymap:primary' format '%{%(#~%F{red}~%F{white})%}%B»%b%f'
zstyle ':config:editor:keymap:alternate' format '%{%(#~%F{red}~%F{white})%}%B«%b%f'

# vcs_info
zstyle ':vcs_info:*' enable bzr cdv cvs darcs fossil git tla hg mtn p4 svn svk
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%F{green}%B✓%b%f'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}%B✕%b%f'
zstyle ':vcs_info:*' formats ' %F{white}%B‹%%b%F{cyan}%b%c%u%F{white}%B›%%b%f'
zstyle ':vcs_info:*' actionformats ' %F{white}%B‹%F{red}⚡%%b%F{cyan}%b%c%u%F{white}%B›%%b%f'

# set prompt
PROMPT='%F{green}%c${vcs_info_msg_0_} %(?..%F{red}%? )${editor_info[keymap]}%f '

cd() {
	builtin cd "$@"
	builtin pwd
}
