#
# Aliases
#

# nocorrect
alias ack='nocorrect ack'
alias cd='nocorrect cd'
alias cp='nocorrect cp -i'
alias grep='nocorrect grep --color=auto'
alias ln='nocorrect ln -i'
alias man='nocorrect man'
alias mkdir='nocorrect mkdir -p'
alias mv='nocorrect mv -i'
alias rm='nocorrect rm -i'

# noglob
alias find='noglob find'
alias ftp='noglob ftp'
alias history='noglob history'
alias locate='noglob locate'
alias rsync='noglob rsync'
alias scp='noglob scp'
alias sftp='noglob sftp'

alias d='dirs -v'
alias df='df -kh'
alias du='df -kh'
alias history-stat='history 0 | awk ''{print $2}'' | sort | uniq -c | sort -n -r | head'
alias l='ls -1A'
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
alias path='echo -e ${PATH//:/\\n}'
alias which-command='whence'
