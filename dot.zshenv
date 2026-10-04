# login shell
#     ~/.zshenv
#     ~/.zprofile
#     ~/.zshrc
#     ~/.zlogin
#
# interactive shell
#     ~/.zshenv
#     ~/.zshrc
#
# shell script
#     ~/.zshenv

# ignore /etc/zprofile, /etc/zshrc, /etc/zlogin, and /etc/zlogout
unsetopt GLOBAL_RCS

export XDG_CONFIG_HOME="${HOME}/.config"

# https://tellme.tokyo/post/2026/10/01/ai-agent-first-dotfiles/
# A human is at the keyboard only if stdin/stdout are a TTY and no known
# agent marker is set. $TERM or -o interactive can't tell: agents inherit
# TERM from the terminal and Claude Code snapshots the rc with `zsh -i`.
# Export AI_AGENT=1 to force the agent side.
is_human() {
    [[ -t 0 && -t 1 ]] || return 1
    [[ -z $CLAUDECODE$CODEX_SANDBOX$GEMINI_CLI$CURSOR_AGENT$AI_AGENT ]]
}

# copied from /etc/zprofile
if [ -x /usr/libexec/path_helper ]; then
    eval `/usr/libexec/path_helper -s`
fi

if [ -x /opt/homebrew/bin/brew ]; then
    eval $(/opt/homebrew/bin/brew shellenv)
fi

typeset -gx -U path
path=(
    ~/bin(N-/)
    ~/.local/bin(N-/)
    ~/.composer/vendor/bin(N-/)
    ~/.cargo/bin(N-/)
    /etc/profiles/per-user/$USER/bin(N-/)
    /run/current-system/sw/bin(N-/)
    /nix/var/nix/profiles/default/bin(N-/)
    /usr/local/bin(N-/)
    /opt/homebrew/bin(N-/)
    "$path[@]"
)

export LANGUAGE="en_US.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"

if is_human; then
    for file in ${HOME}/.sh/[0-9]*; do
        source "$file"
    done
    unset file
else
    # Nobody can answer an editor, pager or password prompt: fail fast
    # instead of hanging
    export EDITOR=true VISUAL=true GIT_EDITOR=true GIT_SEQUENCE_EDITOR=true
    export PAGER=cat GIT_PAGER=cat MANPAGER=cat
    export GIT_TERMINAL_PROMPT=0

    # The interactive direnv hook never fires here, so load .envrc once
    (( $+commands[direnv] )) && eval "$(direnv export zsh)"

    [[ -r "${XDG_CONFIG_HOME}/zsh/ai.zsh" ]] && source "${XDG_CONFIG_HOME}/zsh/ai.zsh"
fi

if command -v assume >/dev/null 2>&1; then
    alias assume='. assume'
fi

# vim: ft=zsh
