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

# shortcuts
alias dirs='dirs -v'
alias df='df -kh'
alias e='$EDITOR'
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"
alias ls='ls --group-directories-first --color=auto'
alias l='ls -1A'
alias ll='ls -lh'
alias la='ll -A'
alias p='$PAGER'
alias path='echo -e ${PATH//:/\\n}'

