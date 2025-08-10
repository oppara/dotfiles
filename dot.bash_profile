
for file in ${HOME}/.sh/[0-9]*; do
    source "$file"
done
unset file

IGNOREEOF=1

ulimit -c 0  # Don't create core dumps

export PROMPT_COMMAND='echo -ne "\033]0;$PWD\007"'
export PS1='\[\]\u > \w\n\$ '

if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi

# vim: ft=sh
