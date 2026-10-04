if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export PAGER=less
export LESS='-f -X -i -R'
export LESSCHARSET='utf-8'
export LANG=en_US.UTF-8

[ -f "${HOME}/.bashrc" ] && . "${HOME}/.bashrc"

# vim: ft=sh
