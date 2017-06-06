#
# Initialize ndenv
#

if [[ -s "$HOME/.ndenv/bin/ndenv" ]]; then
	path=("$HOME/.ndenv/bin" $path)
	eval "$(ndenv init - -no-rehash zsh)"
elif (( $+commands[ndenv] )); then
	eval "$(ndenv init - -no-rehash zsh)"
fi
