export DOTFILES="${HOME}/dotfiles"

for file in ${DOTFILES}/.{paths,colors,exports,aliases,functions}; do
    test -r "$file" && test -f "$file" && source "$file"
done
unset file

#
# prompt
#
autoload -Uz colors
colors

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

# vim: ft=zsh
