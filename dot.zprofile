export LANG=ja_JP.UTF-8

PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"
MANPATH="/usr/share/man"

test -d /Developer/Tools && PATH=/Developer/Tools:$PATH
test -d /opt/local/sbin && PATH=/opt/local/sbin:$PATH
test -d /opt/local/bin && PATH=/opt/local/bin:$PATH
test -d /usr/local/postgresql/bin && PATH=/usr/local/postgresql/bin:$PATH
test -d /usr/local/mysql/bin && PATH=/usr/local/mysql/bin:$PATH
test -d /usr/local/php/bin && PATH=/usr/local/php/bin:$PATH
test -d ~/local/bin && PATH=~/local/bin:$PATH
test -d ~/bin && PATH=~/bin:$PATH

test -d /opt/local/man && MANPATH=/opt/local/man:$MANPATH

export PATH MANPATH

if test -x /opt/local/bin/zsh; then
    export SHELL=/opt/local/bin/zsh
elif test -x /usr/local/bin/zsh; then
    export SHELL=/usr/local/bin/zsh
elif test -x /usr/bin/zsh; then
    export SHELL=/usr/bin/zsh
elif test -x /bin/zsh; then
    export SHELL=/bin/zsh
fi

if test -x /opt/local/bin/lv; then
    export PAGER=/opt/local/bin/lv
    export LV='-Ou8'
elif test -x /usr/local/bin/lv; then
    export PAGER=/usr/local/bin/lv
    export LV='-Ou8'
else
    export PAGER=/usr/bin/less
fi

export LESSCHARSET=utf-8

export BLOCKSIZE=k


test -f ~/.zshrc && . ~/.zshrc

# vim: ft=zsh
