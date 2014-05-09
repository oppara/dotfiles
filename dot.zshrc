HISTFILE="${HOME}/.zsh-history"

ulimit -c 0  # Don't create core dumps

typeset -U path cdpath fpath manpath

## https://github.com/zsh-users/zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)


# global alias
alias -g C="| pbcopy"
alias -g G="| grep"
alias -g L="| less"
alias -g T="| tail"
alias -g H="| head"
alias -g X="| xargs"
alias -g R="| vi -R -"
alias -g W="| w3m -T text/html"
# http://osxdaily.com/2012/07/17/send-a-notification-badge-to-the-terminal-dock-icon-when-a-task-is-finished/
alias -g DOCK="&& tput bel"

#-----------------------------------------------------------------------------
# option, autoload
#-----------------------------------------------------------------------------
## 補完機能の強化
autoload -U compinit
compinit


## ヒストリを呼び出してから実行する間に一旦編集
setopt hist_verify

## ヒストリを共有
setopt share_history

## ヒストリは含まない
setopt hist_no_store

## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups

## 履歴検索機能のショートカット設定
## コマンド履歴の検索機能はCtrl-PとCtrl-N
## 複数行の編集は↓↑←→
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

## Viキーバインド
## bindkey -v
## bindkey '^R' history-incremental-search-backward

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






## zsh の開始, 終了時刻をヒストリファイルに書き込む
setopt extended_history

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



## カッコの対応などを自動的に補完
setopt auto_param_keys

## ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash


#-----------------------------------------------------------------------------
# color
#-----------------------------------------------------------------------------
# 00: なにもしない
# 01: 太字化
# 04: 下線
# 05: 点滅
# 07: 前背色反転
# 08: 表示しない
# 22: ノーマル化
# 24: 下線なし
# 25: 点滅なし
# 27: 前背色反転なし
# 30: 黒(前景色)
# 31: 赤(前景色)
# 32: 緑(前景色)
# 33: 茶(前景色)
# 34: 青(前景色)
# 35: マゼンタ(前景色)
# 36: シアン(前景色)
# 37: 白(前景色)
# 39: デフォルト(前景色)
# 40: 黒(背景色)
# 41: 赤(背景色)
# 42: 緑(背景色)
# 43: 茶(背景色)
# 44: 青(背景色)
# 45: マゼンタ(背景色)
# 46: シアン(背景色)
# 47: 白(背景色)
# 49: デフォルト(背景色)
#-----------------------------------------------------------------------------

## http://journal.mycom.co.jp/column/zsh/009/index.html
# export LSCOLORS=ExFxCxdxBxegedabagacad
export LSCOLORS=ExCxFxdxBxegedabagacad
export LS_COLORS='di=01;34:ln=01;32:so=01;35:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;32;1' 'so=;35;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'

#-----------------------------------------------------------------------------
# prompt
#-----------------------------------------------------------------------------

autoload -Uz colors
colors

#case ${UID} in
#0)
#    PROMPT="%B%{[31m%}%/#%{[m%}%b "
#    PROMPT2="%B%{[31m%}%_#%{31m[m%}%b "
#    SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%}%b "
#    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
#        PROMPT="%{^[[33m%}${HOST%%.*} ${PROMPT}"
#    ;;
#*)
#    PROMPT="%{[37m%}%/%%%{[m%} "
#    PROMPT2="%{[37m%}%_%%%{[m%} "
#    SPROMPT="%{[37m%}%r is correct? [n,y,a,e]:%{[m%} "
#    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
#        PROMPT="%{[33m%}${HOST%%.*} ${PROMPT}"
#    ;;
#esac


PROMPT="
%{[33m%}[%~]%{[m%}
%% "
RPROMPT=''
SPROMPT="correct: %R -> %r ? "


#
# Show branch name in Zsh's right prompt
# http://d.hatena.ne.jp/uasi/20091025/1256458798
# http://gist.github.com/214109
# sudo port install zsh-devel @4.3.10 +doc +pcre +utf8
#
autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

# http://d.hatena.ne.jp/mollifier/20100113/p1
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable svn hg bzr
zstyle ':vcs_info:*' formats '[%s-%b]'
zstyle ':vcs_info:svn:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%s-%b|%a]'
zstyle ':vcs_info:svn:*' actionformats '[%b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true

function get_vsc_info {
  local name st color gitdir action
  if [[ "$PWD" =~ '/¥.git(/.*)?$' ]]; then
    return
  fi

  name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
  if [[ -z $name ]]; then
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
    # echo "%1(v|%F{green}%1v%f|)"
    echo "%{${fg[green]}%}$vcs_info_msg_0_%{$reset_color%}"
    return
  fi


  gitdir=`git rev-parse --git-dir 2> /dev/null`
  action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    color=${fg[green]}
  elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
    color=${fg[yellow]}
  elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
    color=${fg[red]}
  else
    color=${fg[red]}
  fi

  # %{...%} は囲まれた文字列がエスケープシーケンスであることを明示する
  # これをしないと右プロンプトの位置がずれる
  echo "(%{$color%}$name%{$reset_color%})"
}

update_rprompt () {
  RPROMPT=`get_vsc_info`
}

precmd() {
    update_rprompt
    ## カレントディレクトリをコマンドステータス行に
    [ 0 -lt `is_screen` ] && \
        print -nP '\ek%24<*<%~%<<\e\\'
}

chpwd() {
  update_rprompt
}

function preexec() {
    [ 0 -lt `is_screen` ] && \
        echo -ne "\ek#${1%% *}\e\\"
}

function is_screen() {
  if [ "$TERM" = "screen-bce" -o "$TERM" = "screen" ]; then
    echo 1
  else
    echo 0
  fi
}

# http://blog.monoweb.info/article/2011120320.html
sudo() {
  local args
  case $1 in
    vi|vim)
      args=()
      for arg in $@[2,-1]
      do
        if [ $arg[1] = '-' ]; then
          args[$(( 1+$#args ))]=$arg
        else
          args[$(( 1+$#args ))]="sudo:$arg"
        fi
      done
      command vim $args
      ;;
    *)
      command sudo $@
      ;;
  esac
}


# http://blog.glidenote.com/blog/2013/02/26/jumping-to-the-finder-location-in-terminal/
# cd to the path of the front Finder window
cdf() {
  target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
  if [ "$target" != "" ]; then
    cd "$target"; pwd
  else
    echo 'No Finder window found' >&2
  fi
}

# http://blog.glidenote.com/blog/2012/02/29/autojump-zsh/
# sudo sh ./install.sh --local --prefix /usr/local --zsh
[ -f /usr/local/etc/profile.d/autojump.zsh ] && source /usr/local/etc/profile.d/autojump.zsh

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# vim: ft=zsh

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
