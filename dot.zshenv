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

## 重複したパスを登録しない
typeset -U path cdpath fpath manpath


for file in ${HOME}/.sh/[0-9]*; do
    source "$file"
done
unset file


## 補完機能の強化
# brew info zsh-completions
fpath=( \
    $(brew --prefix)/share/zsh-completions \
    $fpath \
    )

autoload -Uz compinit && compinit
autoload -Uz add-zsh-hook
autoload -Uz colors && colors

HISTFILE="${HOME}/.zsh-history"


# vim: ft=zsh
