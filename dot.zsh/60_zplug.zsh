
if [ -e /usr/local/opt/zplug ]; then


export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

zplug "mollifier/cd-gitroot"
alias cgr='cd-gitroot'

zplug "oppara/anyframe"

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi


zplug load


fi

