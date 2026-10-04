[[ $- != *i* ]] && return

IGNOREEOF=1

PROMPT_COMMAND='echo -ne "\033]0;$PWD\007"'
PS1='\u > \w\n\$ '

HISTCONTROL=ignoreboth:erasedups
HISTSIZE=50000
HISTFILESIZE=50000

if [ -f "${HOMEBREW_PREFIX}/etc/bash_completion" ]; then
    . "${HOMEBREW_PREFIX}/etc/bash_completion"
fi

shopt -s globstar autocd dirspell cdspell 2>/dev/null

# vim: ft=sh
