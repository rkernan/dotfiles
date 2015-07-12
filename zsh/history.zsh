#
# History settings
#

HISTFILE="${ZDOTDIR:-$HOME}/.zhistory" # history file path
HISTSIZE=10000                               # max history
SAVEHIST=10000                               # max history to save to file

setopt BANG_HIST              # treat the '!' character specially during expansion
setopt EXTENDED_HISTORY       # write extended history
setopt INC_APPEND_HISTORY     # write to history file immediately
setopt SHARE_HISTORY          # share history between sessions
setopt HIST_EXPIRE_DUPS_FIRST # expire a duplicate event first when pruning the history
setopt HIST_IGNORE_DUPS       # do not record duplicate events
setopt HIST_IGNORE_ALL_DUPS   # delete the older event if it a duplicate of a new one
setopt HIST_FIND_NO_DUPS      # do not display duplicates
setopt HIST_IGNORE_SPACE      # do not record an event that starts with a space
setopt HIST_SAVE_NO_DUPS      # do not write a duplicate event to the history file
setopt HIST_VERIFY            # do not execute immediately on history expansion

# source history-substring-search
source "${0:h}/history-substring-search/zsh-history-substring-search.zsh" || return 1

# history-substring-search key bindings
if [[ -n "$key_info" ]]; then
	# emacs
	bindkey -M emacs "$key_info[Control]P" history-substring-search-up
	bindkey -M emacs "$key_info[Control]N" history-substring-search-down

	# vi
	bindkey -M vicmd "k" history-substring-search-up
	bindkey -M vicmd "j" history-substring-search-down
	bindkey -M viins "$key_info[Control]P" history-substring-search-up
	bindkey -M viins "$key_info[Control]N" history-substring-search-down

	# both
	for keymap in 'emacs' 'viins'; do
		bindkey -M "$keymap" "$key_info[Up]" history-substring-search-up
		bindkey -M "$keymap" "$key_info[Down]" history-substring-search-down
	done
fi
