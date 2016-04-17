# misc

## direnv
if which direnv >/dev/null; then
    eval "$(direnv hook zsh)"
fi

## rbenv
test -d "${HOME}/.rbenv" &&  eval "$(rbenv init -)"

## plenv
test -d "${HOME}/.plenv" &&  eval "$(plenv init -)"

## docker-machine
test -d "${HOME}/.docker/machine/machines/dev" && eval "$(docker-machine env dev)"


# vim: ft=sh fdm=marker
