# misc
export AWS_PAGER=""

## heroku
if which heroku >/dev/null; then
  eval  "$(heroku autocomplete:script zsh)"
fi

## direnv
if which direnv >/dev/null; then
  eval "$(direnv hook zsh)"
fi

if [ -f "${HOME}/.anyenv/bin/anyenv" ]; then
  export PATH="${HOME}/.anyenv/bin:${PATH}"
  eval "$(anyenv init -)"
fi


# ## docker-machine dev
# if [[ $(docker-machine ls | grep dev | grep Running 2> /dev/null) ]]; then
  # eval "$(docker-machine env dev)"
# fi

## composer
if which symfony-autocomplete >/dev/null; then
  eval "$(symfony-autocomplete)"
fi


# The next line updates PATH for the Google Cloud SDK.
test -f "${HOME}/google-cloud-sdk/path.zsh.inc" && "${HOME}/google-cloud-sdk/path.zsh.inc"

# The next line enables shell command completion for gcloud.
test -f "${HOME}/google-cloud-sdk/completion.zsh.inc" && "${HOME}/google-cloud-sdk/completion.zsh.inc"


if [ -L "${HOMEBREW_PREFIX}/bin/terraform" ]; then
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C "${HOMEBREW_PREFIX}/bin/terraform" terraform
fi

# 1password
if [ -x "$(command -v op)" ]; then
    eval "$(op completion zsh)"; compdef _op op
fi

# vim: ft=sh fdm=marker
