#
# prompt
#

PROMPT="%F{yellow}%~%f
%# "
PROMPT2="%F{white}%_> %f"
SPROMPT="%F{red}correct: %R -> %r [nyae]? %f"
RPROMPT=''

autoload -Uz vcs_info
autoload -Uz add-zsh-hook
autoload -Uz is-at-least


zstyle ':vcs_info:*' max-exports 4
zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b]' '%m' '%m' '<!%a>'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true


if is-at-least 4.3.10; then
    zstyle ':vcs_info:git:*' formats '%b' '%c%u' '%m'
    zstyle ':vcs_info:git:*' actionformats '%b' '%c%u' '%m' '<!%a>'
    zstyle ':vcs_info:git:*' check-for-changes true
    # %c で表示する文字列
    zstyle ':vcs_info:git:*' stagedstr "S"
    # %u で表示する文字列
    zstyle ':vcs_info:git:*' unstagedstr "U"
fi

# hooks 設定
# http://qiita.com/mollifier/items/8d5a627d773758dd8078
if is-at-least 4.3.11; then
    # git のときはフック関数を設定する

    zstyle ':vcs_info:git+set-message:*' hooks \
                                            git-hook-begin \
                                            git-untracked \
                                            git-stash-count

    # フックの最初の関数
    # git の作業コピーのあるディレクトリのみフック関数を呼び出すようにする
    # (.git ディレクトリ内にいるときは呼び出さない)
    # .git ディレクトリ内では git status --porcelain などがエラーになるため
    function +vi-git-hook-begin() {
        if [[ $(command git rev-parse --is-inside-work-tree 2> /dev/null) != 'true' ]]; then
            # 0以外を返すとそれ以降のフック関数は呼び出されない
            return 1
        fi

        return 0
    }

    # untracked ファイル表示
    #
    # untracked ファイル(バージョン管理されていないファイル)がある場合は
    # misc (%m) に ? を表示
    function +vi-git-untracked() {
        if [[ "$1" != "2" ]]; then
            return 0
        fi

        if command git status --porcelain 2> /dev/null \
            | awk '{print $1}' \
            | command grep -F '??' > /dev/null 2>&1 ; then

            # misc (%m) に追加
            hook_com[misc]+='?'
        fi
    }

    # stash 件数表示
    function +vi-git-stash-count() {
        if [[ "$1" != "2" ]]; then
            return 0
        fi

        local stash
        stash=$(command git stash list 2>/dev/null | wc -l | tr -d ' ')
        if [[ "${stash}" -gt 0 ]]; then
          stash=`expr $stash - 1`
          hook_com[misc]+="@{${stash}}"
        fi
    }

fi

function _update_vcs_info_msg() {
    local -a messages
    local color

    LANG=en_US.UTF-8 vcs_info

    if [[ -z ${vcs_info_msg_0_} ]]; then
      RPROMPT=""
      return 0
    fi

    color="green"
    if [[ `echo ${vcs_info_msg_1_} | grep 'S'` ]] ; then
      color="yellow"
    fi
    if [[ `echo ${vcs_info_msg_1_} | grep 'U'` ]] ; then
      color="red"
    fi
    if [[ -n "$vcs_info_msg_3_" ]] ; then
      vcs_info_msg_2_=""
      color="red"
    fi

    [[ -n "$vcs_info_msg_0_" ]] && messages+=( "%F{$color}${vcs_info_msg_0_}%f" )
    [[ -n "$vcs_info_msg_2_" ]] && messages+=( "%F{yellow}${vcs_info_msg_2_}%f" )
    [[ -n "$vcs_info_msg_3_" ]] && messages+=( "%F{red}${vcs_info_msg_3_}%f" )

    RPROMPT="${(j: :)messages}"
}
add-zsh-hook precmd _update_vcs_info_msg

precmd() {
    ## カレントディレクトリをコマンドステータス行に
    [ 0 -lt `is_screen` ] && \
        print -nP '\ek%24<*<%~%<<\e\\'
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


# vim: ft=sh fdm=marker
