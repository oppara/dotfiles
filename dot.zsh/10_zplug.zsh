export ZPLUG_HOME="/usr/local/opt/zplug"

if [ ! -e ${ZPLUG_HOME} ]; then
    return 0
fi

source "${ZPLUG_HOME}/init.zsh"

zplug "zplug/zplug", hook-build:"zplug --self-manage"

zplug "mollifier/cd-gitroot"
alias cgr="cd-gitroot"

zplug "oppara/anyframe"
bindkey "^r" anyframe-widget-put-history
bindkey "^g^g" anyframe-widget-cd-ghq-repository
bindkey "^s^s" anyframe-widget-insert-ssh-host
bindkey "^g^i" anyframe-widget-insert-git-branch
alias gco=anyframe-widget-checkout-git-branch


if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi


zplug load



