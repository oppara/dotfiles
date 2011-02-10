
export LANG=ja_JP.UTF-8
export SHELL=/opt/local/bin/zsh
export MANPATH=$MANPATH:/opt/local/man

## PATH
export PATH=~/bin:\
/usr/local/bin:\
/usr/local/php/bin:\
/usr/local/mysql/bin:\
/usr/local/postgresql/bin:\
/usr/local/mtasc:\
/opt/local/bin:\
/Developer/Tools:\
/usr/local/sbin:\
/usr/bin:/usr/sbin:\
/bin:/sbin:\
$PATH:\
/Users/oppara/Sites/try/php/cake/cake/console

## kcode
alias kcode='~/bin/kcode -i utf8 -o utf8'

## less
export LESSCHARSET=utf-8
alias  le='less'

export LV='-Ou8'
test -x /opt/local/bin/lv && alias less=/opt/local/bin/lv

## ls
alias ls='ls -F'
alias la='ls -a'
alias ll='ls -lh'

## vim
alias vi='~/bin/vim'
alias vim='~/bin/mvim  --remote-silent'
# alias vim='/Applications/MacVim.app/Contents/MacOS/Vim -g --remote-silent'
# alias vim='open -a Vim'
# function vim() {
    # for i in "$@"; do;
        # if [ ! -e "$i" ];then
            # touch "$i"
        # fi
        # open -a Vim "$i"
    # done;
# }

export EDITOR='vi'
export SVN_EDITOR='vi'
export GIT_EDITOR='vi'
# export GIT_PAGER='lv -c'
export GIT_PAGER='cat'

## YUI Compressor
alias com='java -jar ~/bin/yuicompressor.jar'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 

## 補完機能の強化
autoload -U compinit
compinit

## o
# Usage:
# % pwd C
alias -g C="| pbcopy"
alias -g G="| grep"
alias -g L="| lv"
alias -g W="| w3m -T text/html"



## 30  31  32  33  34  35  36  37
## 黒  赤  緑  黄  青  紫  水  白
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

## http://unknownplace.org/memo/2008/02/04
# PROMPT='%(?..exit %?)
#  %{[33m%}%~%{[m%} %{[91m%}`$HOME/.zsh.d/repospath.pl $(pwd)`%{[m%}
#  %{[38m%}%(!.#.$)%{[m%}%{m%} '

PROMPT="
%{[33m%}[%~]%{[m%}
%% "
RPROMPT=''
SPROMPT="correct: %R -> %r ? "

HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000

## ヒストリを呼び出してから実行する間に一旦編集
setopt hist_verify

## ヒストリを共有
setopt share_history

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

## 色を使う
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

## http://journal.mycom.co.jp/column/zsh/009/index.html
# export LSCOLORS=exfxcxdxbxegedabagacad
# export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

alias ls="ls -G"
export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    


RESET="%{${reset_color}%}"
local BLACK=$'%{[30m%}'
local RED=$'%{[31m%}'
local GREEN=$'%{[32m%}'
local YELLOW=$'%{[33m%}'
local BLUE=$'%{[34m%}'
local PURPLE=$'%{[35m%}'
local LIGHT_BLUE=$'%{[36m%}'
local WHITE=$'%{[37m%}'


#
# Show branch name in Zsh's right prompt
# http://d.hatena.ne.jp/uasi/20091025/1256458798
# http://gist.github.com/214109
# sudo port install zsh-devel @4.3.10 +doc +pcre +utf8
#
autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

function rprompt-git-current-branch {
        local name st color gitdir action
        if [[ "$PWD" =~ '/¥.git(/.*)?$' ]]; then
                return
        fi
        name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
        if [[ -z $name ]]; then
                return
        fi

        gitdir=`git rev-parse --git-dir 2> /dev/null`
        action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

        st=`git status 2> /dev/null`
        if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
#                 color=%F{green}
                color=$GREEN
        elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
#                 color=%F{yellow}
                color=$YELLOW
        elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
#                 color=%B%F{red}
                color=$RED
        else
#                  color=%F{red}
                 color=$RED
         fi
              
        echo "($color$name$action%f%b)"
}

setopt prompt_subst

_update_rprompt () {
  RPROMPT=`rprompt-git-current-branch`
} 

precmd() {
    _update_rprompt
    ## カレントディレクトリをコマンドステータス行に
    # if [[ "$TERM" = "screen" ]]; then
    if [[ "$TERM" != "xterm-color" ]]; then
        print -nP '\ek%24<*<%~%<<\e\\'
    fi
}
 
chpwd() {
  _update_rprompt
}

 
## 最後に打ったコマンドステータス行に
if [ "$TERM" = "screen" ]; then
# if [ "$TERM" != "xterm-color" ]; then
 preexec() {
   # see [zsh-workers:13180]
   # http://www.zsh.org/mla/workers/2000/msg03993.html
   emulate -L zsh
   local -a cmd; cmd=(${(z)2})
   echo -n "k$cmd[1]:t\\"
 }
fi

# http://www.vim.org/scripts/script.php?script_id=2098
export __CF_USER_TEXT_ENCODING="0x1F5:0x08000100:14"


# http://webtech-walker.com/archive/2009/10/06093250.html
# zshから辞書を引く
function alc() {
if [ $# != 0 ]; then
    w3m "http://eow.alc.co.jp/$*/UTF-8/?ref=sa"
else
    echo 'usage: alc word'
fi
}

source $HOME/perl5/perlbrew/etc/bashrc
