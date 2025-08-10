# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
# in ~/.zshenv, executed `unsetopt GLOBAL_RCS` and ignored /etc/zshrc
[ -r /etc/zshrc ] && . /etc/zshrc

export HISTSIZE=100000
export SAVEHIST=${HISTSIZE}
export HISTFILESIZE=${HISTSIZE}

for file in ~/.zsh/[0-9]*.(sh|zsh)
do
    source "$file"
done
unset file

zstyle ':completion:*' use-cache yes

## 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1

## 補完候補の色づけ
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;32;1' 'so=;35;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'



[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# vim: ft=zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"



[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# bun completions
[ -s "/Users/oppara/.bun/_bun" ] && source "/Users/oppara/.bun/_bun"

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/oppara/tmp/gloud/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/oppara/tmp/gloud/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/oppara/tmp/gloud/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/oppara/tmp/gloud/google-cloud-sdk/completion.zsh.inc'; fi
