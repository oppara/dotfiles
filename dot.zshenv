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

# Don't create core dumps
ulimit -c 0


for file in ${HOME}/.sh/[0-9]*; do
    source "$file"
done
unset file


if command -v assume >/dev/null 2>&1; then
    alias assume='. assume'
fi

# vim: ft=zsh
