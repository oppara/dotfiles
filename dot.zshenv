# login shell
#     ~/.zshenv
#     ~/.zprofile
#     ~/.zshrc
#     ~/.zlogin
#
# interactive shell
#     ~/.zshenv
#     ~/.zshrc
#
# shell script
#     ~/.zshenv

# ignore /etc/zprofile, /etc/zshrc, /etc/zlogin, and /etc/zlogout
unsetopt GLOBAL_RCS

# copied from /etc/zprofile
if [ -x /usr/libexec/path_helper ]; then
    eval `/usr/libexec/path_helper -s`
fi

if [ -x /opt/homebrew/bin/brew ]; then
    eval $(/opt/homebrew/bin/brew shellenv)
fi
if [ -x /usr/local/bin/brew ]; then
    eval $(/usr/local/bin/brew shellenv)
fi

# Don't create core dumps
ulimit -c 0


for file in ${HOME}/.sh/[0-9]*; do
    source "$file"
done
unset file


# vim: ft=zsh
