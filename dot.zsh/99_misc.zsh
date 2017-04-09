# misc

## direnv
if which direnv >/dev/null; then
    eval "$(direnv hook zsh)"
fi

## rbenv
test -d "${HOME}/.rbenv" &&  eval "$(rbenv init -)"

## plenv
test -d "${HOME}/.plenv" &&  eval "$(plenv init -)"

## docker-machine dev
if [[ $(docker-machine ls | grep dev | grep Running 2> /dev/null) ]]; then
  eval "$(docker-machine env dev)"
fi


# vim: ft=sh fdm=marker
