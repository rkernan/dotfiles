#
# Initialize pyenv
#

if [[ -s "$HOME/.pyenv/bin/pyenv" ]]; then
	path=("$HOME/.pyenv/bin" $path)
	eval "$(pyenv init - --no-rehash zsh)"
	eval "$(pyenv virtualenv-init - --no-rehash zsh)"
elif (( $+commands[pyenv] )); then
	eval "$(pyenv init - --no-rehash zsh)"
	eval "$(pyenv virtualenv-init - --no-rehash zsh)"
fi
