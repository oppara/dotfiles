# misc

## heroku
if which heroku >/dev/null; then
  eval  "$(heroku autocomplete:script zsh)"
fi

## direnv
if which direnv >/dev/null; then
  eval "$(direnv hook zsh)"
fi

if [[ -f "${HOME}/.anyenv/bin/anyenv" ]]; then
  export PATH="${HOME}/.anyenv/bin:${PATH}"
  eval "$(anyenv init -)"
fi

# ## docker-machine dev
# if [[ $(docker-machine ls | grep dev | grep Running 2> /dev/null) ]]; then
  # eval "$(docker-machine env dev)"
# fi

plugin="${COMPOSER_HOME-$HOME/.composer}/vendor/stecman/composer-bash-completion-plugin"
test -d "${plugin}" &&  source "${plugin}/hooks/zsh-completion"
unset plugin


# The next line updates PATH for the Google Cloud SDK.
if [ -f "${HOME}/google-cloud-sdk/path.zsh.inc" ]; then . "${HOME}/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "${HOME}/google-cloud-sdk/completion.zsh.inc" ]; then . "${HOME}/google-cloud-sdk/completion.zsh.inc"; fi

if [[ -L "/usr/local/bin/terraform" ]]; then
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C /usr/local/bin/terraform terraform
fi

# vim: ft=sh fdm=marker
