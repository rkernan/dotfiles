#
# Initialize rbenv
#

if [[ -s "$HOME/.rbenv/bin/rbenv" ]]; then
	path=("$HOME/.rbenv/bin" $path)
	eval "$(rbenv init - -no-rehash zsh)"
elif (( $+commands[rbenv] )); then
	eval "$(rbenv init - -no-rehash zsh)"
fi
