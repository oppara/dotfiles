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


# Don't create core dumps
ulimit -c 0


for file in ${HOME}/.sh/[0-9]*; do
    source "$file"
done
unset file


# vim: ft=zsh
