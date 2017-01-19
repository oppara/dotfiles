
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
