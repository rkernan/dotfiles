export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

alias path='echo -e ${PATH//:/\\n}'
alias e='"$EDITOR"'

alias 1='cd +1'
alias 2='cd +2'
alias 3='cd +3'
alias 4='cd +4'
alias 5='cd +5'
alias 6='cd +6'
alias 7='cd +7'
alias 8='cd +8'
alias 9='cd +9'
alias po='popd'
alias pu='pushd'

alias ln='ln -i'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -p'

alias d='dirs -v'
alias l='ls -lA'
alias la='ll -A'
alias lc='lt -c'
alias lk='ll -Sr'
alias ll='ls -lh'
alias lm='la | "$PAGER"'
alias lr='ll -R'
alias ls='ls --group-directories-first --color=auto'
alias lt='ll -tr'
alias lu='lt -u'
alias lx='ll -XB'

alias df='df -kh'
alias du='du -kh'
alias fc='noglob fc'

alias grep='grep --color=auto'

alias type='type -a'

alias pbc='pbcopy'
alias pbp='pbpaste'
if [[ "$OSTYPE" != "darwin" ]]; then
	alias pbcopy='xclip -selection clipboard -in'
	alias pbpaste='xclip -selection clipboard -out'
fi

function cd() {
	builtin cd "$*"
	builtin pwd
}

export PS1='\[\e[0;34m\]\W\[\e[m\] » '
