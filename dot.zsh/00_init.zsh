HISTFILE="${HOME}/.zsh-history"

## 重複したパスを登録しない
typeset -U path cdpath fpath manpath


## 補完機能の強化
# brew info zsh-completions
fpath=( \
    $(brew --prefix)/share/zsh-completions \
    $fpath \
    )

autoload -Uz compinit && compinit -u
autoload -Uz add-zsh-hook
autoload -Uz colors && colors

