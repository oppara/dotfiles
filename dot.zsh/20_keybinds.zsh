# キーバインド
## 設定しないと環境変数 EDITORやVISUALを参照するので設定
bindkey -e

# Shift-Tabで補完候補を逆順移動
bindkey "^[[Z" reverse-menu-complete


## 履歴検索機能のショートカット設定
## コマンド履歴の検索機能はCtrl-PとCtrl-N
## 複数行の編集は↓↑←→
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end


# http://qiita.com/matsu_chara/items/8372616f52934c657214
typeset -A abbreviations
abbreviations=(
    "V"    "| vim -"
    "R"    "| vi -R -"
    "C"    "| pbcopy"
    "D"    "&& tput bel"
    "G"    "| grep"
    "X"    "| xargs"
    "T"    "| tail"
    "H"    "| head"
    "L"    "| lv"
    "W"    "| wc"
    "A"    "| awk"
    "S"    "| sed"
    "N"    "2>&1 > /dev/null"
    "PT"    "| pandoc --to=textile | pbcopy"
    "F"    "| fpp"
)
magic-abbrev-expand() {
    local MATCH
    LBUFFER=${LBUFFER%%(#m)[-_a-zA-Z0-9]#}
    LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
    zle self-insert
}
no-magic-abbrev-expand() {
    LBUFFER+=' '
}
zle -N magic-abbrev-expand
zle -N no-magic-abbrev-expand
bindkey " " magic-abbrev-expand
bindkey "^i " no-magic-abbrev-expand


# ghq peco
# http://masteries.papix.net/entry/2014-07-05-ghq-with-peco-and-cpanghq.html
stty stop undef
function peco-src () {
    local selected_dir=$(ghq list --full-path | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-src
bindkey '^g^g' peco-src

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

complete-ssh-host() {
  local host="$(command egrep -i '^Host\s+.+' $HOME/.ssh/config $(find $HOME/.ssh/conf.d -type f 2>/dev/null) | command egrep -v '[*?]' | awk '{print $2}' | sort | peco)"

  if [ ! -z "$host" ]; then
    LBUFFER+="$host"
  fi
  zle reset-prompt
}
zle -N complete-ssh-host
bindkey '^s^s' complete-ssh-host


# http://d.hatena.ne.jp/itchyny/20130227/1361933011
function extract() {
  case $1 in
    *.tar.gz|*.tgz) tar xzvf $1;;
    *.tar.xz) tar Jxvf $1;;
    *.zip) unzip $1;;
    *.lzh) lha e $1;;
    *.tar.bz2|*.tbz) tar xjvf $1;;
    *.tar.Z) tar zxvf $1;;
    *.gz) gzip -dc $1;;
    *.bz2) bzip2 -dc $1;;
    *.Z) uncompress $1;;
    *.tar) tar xvf $1;;
    *.rar) unar $1;;
    *.arj) unarj $1;;
  esac
}
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz,rar}=extract


# vim: ft=sh fdm=marker
