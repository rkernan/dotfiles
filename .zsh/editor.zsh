#
# Editor key bindings
#

# readable keys
zmodload zsh/terminfo
typeset -gA key_info
key_info=(
	'Control'      '\C-'
	'ControlLeft'  '\e[1;5D \e[5D \e\e[D \eOd'
	'ControlRight' '\e[1;5C \e[5C \e\e[C \eOc'
	'Escape'       '\e'
	'Meta'         '\M-'
	'Backspace'    "^?"
	'Delete'       "^[[3~"
	'F1'           "$terminfo[kf1]"
	'F2'           "$terminfo[kf2]"
	'F3'           "$terminfo[kf3]"
	'F4'           "$terminfo[kf4]"
	'F5'           "$terminfo[kf5]"
	'F6'           "$terminfo[kf6]"
	'F7'           "$terminfo[kf7]"
	'F8'           "$terminfo[kf8]"
	'F9'           "$terminfo[kf9]"
	'F10'          "$terminfo[kf10]"
	'F11'          "$terminfo[kf11]"
	'F12'          "$terminfo[kf12]"
	'Insert'       "$terminfo[kich1]"
	'Home'         "$terminfo[khome]"
	'PageUp'       "$terminfo[kpp]"
	'End'          "$terminfo[kend]"
	'PageDown'     "$terminfo[knp]"
	'Up'           "$terminfo[kcuu1]"
	'Left'         "$terminfo[kcub1]"
	'Down'         "$terminfo[kcud1]"
	'Right'        "$terminfo[kcuf1]"
	'BackTab'      "$terminfo[kcbt]"
)

# expose vi mode info
function editor-info {
	unset editor_info
	typeset -gA editor_info

	if [[ "$KEYMAP" == 'vicmd' ]]; then
		zstyle -s ':config:editor:keymap:alternate' format 'reply'
		editor_info[keymap]="$reply"
	else
		zstyle -s ':config:editor:keymap:primary' format 'reply'
		editor_info[keymap]="$reply"
	fi

	if [[ "$ZLE_STATE" == *overwrite* ]]; then
		zstyle -s ':config:editor:keymap:primary:overwrite' format 'reply'
		editor_info[overwrite]="$reply"
	else
		zstyle -s ':config:editor:keymap:primary:insert' format 'reply'
		editor_info[overwrite]="$reply"
	fi

	unset reply

	zle reset-prompt
	zle -R
}
zle -N editor-info

# update editor info when the keymap changes
function zle-keymap-select zle-line-init zle-line-finish {
	zle editor-info
}
zle -N zle-keymap-select
zle -N zle-line-init
zle -N zle-line-finish

# toggle emacs overwrite mode and update editor info
function overwrite-mode {
	zle .overwrite-mode
	zle editor-info
}
zle -N overwrite-mode

# enter vi insert mode and update editor info
function vi-insert {
	zle .vi-insert
	zle editor-info
}
zle -N vi-insert

# move to first non-blank character, enter vi insert mode, and update editor info
function vi-insert-bol {
	zle .vi-insert-bol
	zle editor-info
}
zle -N vi-insert-bol

# enter vi replace mode and update editor info
function vi-replace {
	zle .vi-replace
	zle editor-info
}
zle -N vi-replace

# display an indicator when completing
function expand-or-complete-with-indicator {
	local indicator
	zstyle -s ':config:editor:completing' format 'reply'
	print -Pn "$reply"
	zle expand-or-complete
	zle redisplay
}
zle -N expand-or-complete-with-indicator

# undo/redo
bindkey -M vicmd "u" undo
bindkey -M vicmd "$key_info[Control]R" redo
bindkey -M emacs "$key_info[Control]X$key_info[Control]R" redo

# edit command in external editor
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd "v" edit-command-line

# insert sudo at beginning of line
function prepend-sudo {
	if [[ "$BUFFER" != su(do|)\ * ]]; then
		BUFFER="sudo $BUFFER"
		(( CURSOR += 5 ))
	fi
}
zle -N prepend-sudo

bindkey -M vicmd "!" prepend-sudo
bindkey -M emacs "$key_info[Control]X$key_info[Control]R" prepend-sudo

for keymap in 'emacs' 'viins'; do
	bindkey -M "$keymap" "$key_info[Home]" beginning-of-line
	bindkey -M "$keymap" "$key_info[End]" end-of-line
	bindkey -M "$keymap" "$key_info[Insert]" overwrite-mode
	bindkey -M "$keymap" "$key_info[Delete]" delete-char
	bindkey -M "$keymap" "$key_info[Backspace]" backward-delete-char
	bindkey -M "$keymap" "$key_info[Left]" backward-char
	bindkey -M "$keymap" "$key_info[Right]" forward-char

	# shift+tab to go to previous completion menu item
	bindkey -M "$keymap" "$key_info[BackTab]" reverse-menu-complete

	# complete in the middle of a word
	bindkey -M "$keymap" "$key_info[Control]I" expand-or-complete

	# display and indicator when completing
	bindkey -M "$keymap" "$key_info[Control]I" expand-or-complete-with-indicator
done

# set key bindings
zstyle -s ':config:editor' key-bindings 'key_bindings'
if [[ "$key_bindings" == (emacs|) ]]; then
	bindkey -e
elif [[ "$key_bindings" == vi ]]; then
	bindkey -v
else
	print "invalid key bindings: $key_bindings" >&2
fi

# clean up
unset key{,map,bindings}
