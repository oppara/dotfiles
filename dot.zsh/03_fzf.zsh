
if [ -x "$(command -v fzf)" ]; then
    if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
        export PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
    fi

    # Auto-completion
    [[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null

    # Key bindings
    source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"

    export FZF_DEFAULT_OPTS="--layout=reverse --inline-info"
    if [[ -n $TMUX ]]; then
        export FZF_TMUX=1
    fi
fi

