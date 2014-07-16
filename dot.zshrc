# Don't create core dumps
ulimit -c 0

# http://qiita.com/matsu_chara/items/8372616f52934c657214
typeset -A abbreviations
abbreviations=(
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
    "E"    "2>&1 > /dev/null"
    "N"    "> /dev/null"
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


# パス
## 重複したパスを登録しない
typeset -U path cdpath fpath manpath


## 補完機能の強化
# brew info zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)
autoload -U compinit
compinit


# ヒストリ
## ヒストリを保存するファイル
HISTFILE="${HOME}/.zsh-history"

## zsh の開始, 終了時刻をヒストリファイルに書き込む
setopt extended_history
## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups
## ヒストリを共有
setopt share_history
## ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_all_dups
## スペースで始まるコマンドラインはヒストリに追加しない。
setopt hist_ignore_space
## ヒストリは含まない
setopt hist_no_store
## 古いコマンドと同じものは無視
setopt hist_save_no_dups
## ヒストリを呼び出してから実行する間に一旦編集
setopt hist_verify
## 余分な空白は詰めて記録
setopt hist_reduce_blanks
## 補完時にヒストリを自動的に展開
setopt hist_expand
## 履歴をインクリメンタルに追加
setopt inc_append_history
## C-sでのヒストリ検索が潰されてしまうため、出力停止・開始用にC-s/C-qを使わない。
setopt no_flow_control

## 履歴検索機能のショートカット設定
## コマンド履歴の検索機能はCtrl-PとCtrl-N
## 複数行の編集は↓↑←→
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end


# キーバインド
## 設定しないと環境変数 EDITORやVISUALを参照するので設定
bindkey -e


## ディレクトリ名だけで cd
setopt auto_cd

## cd 時に自動で push
setopt autopushd

## 同じディレクトリを pushd しない
setopt pushd_ignore_dups

## ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
setopt extended_glob

## TAB で順に補完候補を切り替える
setopt auto_menu

## スペルチェック
setopt correct

## ビープを鳴らさない
setopt nobeep
setopt nolistbeep

## 補完候補を詰めて表示
setopt list_packed


## コアダンプサイズを制限
limit coredumpsize 102400

## 出力の文字列末尾に改行コードが無い場合でも表示
unsetopt promptcr

## PROMPT 変数の中の変数参照をプロンプト表示時に展開
setopt prompt_subst



## 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt long_list_jobs

## 補完候補一覧でファイルの種別をマーク表示
setopt list_types

## サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt auto_resume

## 補完候補を一覧表示
setopt auto_list


## =command を command のパス名に展開する
setopt equals

## --prefix=/usr などの = 以降も補完
setopt magic_equal_subst



# ファイル名の展開で辞書順ではなく数値的にソート
setopt numeric_glob_sort

## 出力時8ビットを通す
setopt print_eight_bit

## 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1

## 補完候補の色づけ
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;32;1' 'so=;35;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'


## カッコの対応などを自動的に補完
setopt auto_param_keys

## ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

# sheet
# http://blog.glidenote.com/blog/2012/04/16/sheet/
compdef _sheets sheet
function _sheets {
  local -a cmds
  _files -W  ~/.sheets/ -P '~/.sheets/'

  cmds=('list' 'edit' 'copy')
  _describe -t commands "subcommand" cmds

  return 1;
}

# peco history
# http://blog.kenjiskywalker.org/blog/2014/06/12/peco/
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# http://blog.glidenote.com/blog/2012/02/29/autojump-zsh/
# http://blog.zoncoen.net/blog/2014/01/14/percol-autojump-with-zsh/
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# vim: ft=zsh

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
