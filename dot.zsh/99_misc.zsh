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

plugin="${COMPOSER_HOME-$HOME/.composer}/vendor/stecman/composer-bash-completion-plugin"
test -d "${plugin}" &&  source "${plugin}/hooks/zsh-completion"
unset plugin

# vim: ft=sh fdm=marker
