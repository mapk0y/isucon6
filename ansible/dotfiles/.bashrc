# .bashrc

# User specific aliases and functions

HOST=`hostname`

# Source definitions
for prof in /etc/bashrc ${HOME}/.prof_local ${HOME}/.bash_local; do
  [ -f "${prof}" ] && source ${prof}
done

if [ -f /etc/bash_completion ];then
  source /etc/bash_completion
fi

if type __git_ps1 >/dev/null 2>&1; then
  export PS1="\[\033[1;32m\][\u@\h:\w]\[\033[1;32m\]\[\033[1;35m\]\$(__git_ps1 '(%s)')\[\033[0m\]\[\033[1;32m\]\$ \[\033[0m\]"
else
  export PS1='\[\033[1;32m\][\u@\h:\w]\$ \[\033[0m\]'
fi

function tmux() {
    local TMUX
    if command -v tmux 2>&1; then
        TMUX="$(type -P tmux)"
    else
        echo "tmux not found" >&2
        exit 2
    fi

    # 256 color
    TMUX="${TMUX} -2"
    local TMUX_CONF
    TMUX_CONF=${TMP_HOME}/.tmux.conf

    if [ -f ${TMUX_CONF} ]; then
        TMUX="${TMUX} -f ${TMUX_CONF}"
    fi

    if [ -n "${SSH_USER}" ];then
        TMUX="${TMUX} -L ${SSH_USER}"
    fi
    if [ 0 -ne $# ]; then
        ${TMUX} $@
    else
        if ${TMUX} ls > /dev/null 2>&1; then
            ${TMUX} attach
        else
            ssh-agent ${TMUX}
        fi
    fi
}


alias ls='ls -F --color=auto'
alias ll='ls -la'
alias l='ll'
alias sl='ls'

alias info='info --vi-keys'
alias screen='screen -U'

# set PATH
for binpath in /sw/bin ${HOME}/local/sbin ${HOME}/local/bin; do
  [ -d ${binpath} ] && PATH="${binpath}":"${PATH}"
done

PAGER=less
EDITOR=vim
export LANG=C
export LC_MESSAGES=C
PATH=${PATH}:/sbin:/usr/sbin

# vim-backup
if [ ! -d ${HOME}/.vim-backup ]; then
  if [ -d ${HOME}/LOCAL ]; then
    mkdir -vp ${HOME}/LOCAL/.vim-backup
  else
    mkdir -vp ${HOME}/.vim-backup
  fi
fi

# Redirection Overwirite Escape
# ex. "cat < ls.txt > ls.txt"
set -o noclobber

if [ -f ${HOME}/.domain ]; then
  :
else
  echo "isucon5" >${HOME}/.domain
fi

PROMPT_COMMAND='echo -ne "\033]0;$(cat ${HOME}/.domain 2>/dev/null)\007"'

# vim: ts=2 sw=2 sts=0:
