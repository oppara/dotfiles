
if [ -x "$(command -v fzf)" ]; then
    if [[ ! "$PATH" == *${HOMEBREW_PREFIX}/opt/fzf/bin* ]]; then
        export PATH="${PATH:+${PATH}:}${HOMEBREW_PREFIX}/opt/fzf/bin"
    fi

    # Auto-completion
    [[ $- == *i* ]] && source "${HOMEBREW_PREFIX}/opt/fzf/shell/completion.zsh" 2> /dev/null

    # Key bindings
    source "${HOMEBREW_PREFIX}/opt/fzf/shell/key-bindings.zsh"

    export FZF_DEFAULT_OPTS="--layout=reverse --inline-info"
    if [[ -n $TMUX ]]; then
        export FZF_TMUX=1
    fi
fi

