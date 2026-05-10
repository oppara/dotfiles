## sudo  #{{{1
# http://blog.monoweb.info/article/2011120320.html
sudo() {
  local args
  case $1 in
    v | vi | vim)
      args=()
      for arg in $@[2,-1]; do
        if [ $arg[1] = '-' ]; then
          args[$((1 + $#args))]=$arg
        else
          args[$((1 + $#args))]="sudo:$arg"
        fi
      done
      command vim $args
      ;;
    *)
      command sudo $@
      ;;
  esac
}

## ssh  #{{{1
# http://qiita.com/shrkw/items/167be53796d4507c736b
function ssh() {
  if [[ -n $(printenv TMUX) ]]; then
    local window_name=$(tmux display -p '#{window_name}')
    tmux rename-window -- "$@[-1]" # zsh specified
    # tmux rename-window -- "${!#}" # for bash
    command ssh $@
    tmux rename-window $window_name
  else
    command ssh $@
  fi
}

## gitignore #{{{1
# https://github.com/joeblau/gitignore.io
function gi() { curl -L -s https://www.gitignore.io/api/$@; }

## alc #{{{1
function alc() {
  if [ $# != 0 ]; then
    w3m "http://eow.alc.co.jp/$*/UTF-8/?ref=sa" | less +38
  else
    w3m "http://www.alc.co.jp/"
  fi
}

## mc mkdir + cd #{{{1
function mc() {
  [ -n "$1" ] && mkdir -p "$1" && cd "$1"
}

# cd to the path of the front Finder window #{{{1
# http://blog.glidenote.com/blog/2013/02/26/jumping-to-the-finder-location-in-terminal/
cdf() {
  target=$(osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)')
  if [ "$target" != "" ]; then
    cd "$target"
    pwd
  else
    echo 'No Finder window found' >&2
  fi
}

## checker for colors for .zshrc #{{{1
function pcolor() {
  for ((f = 0; f < 255; f++)); do
    printf "\e[38;5;%dm %3d\e[m" $f $f
    if [[ $f%8 -eq 7 ]]; then
      printf "\n"
    fi
  done
  echo
}

## rg edit #{{{1
alias vv="_rgAndVim"
_rgAndVim() {
  if [ -z "$1" ]; then
    echo 'Usage: vv PATTERN'
    return 0
  fi
  result=$(rg -n --hidden "${1}" | fzf)
  line=$(echo "$result" | awk -F ':' '{print $2}')
  file=$(echo "$result" | awk -F ':' '{print $1}')
  if [ -n "$file" ]; then
    nvim "$file" +"${line}"
  fi
}

## git worktree #{{{1
function gwt() {
  GIT_CDUP_DIR=$(git rev-parse --show-cdup)
  git worktree add ${GIT_CDUP_DIR}git-worktrees/$1 -b $1
}

alias cwt="cdworktree"
function cdworktree() {
  git rev-parse &>/dev/null
  if [ $? -ne 0 ]; then
    echo fatal: Not a git repository.
    return
  fi

  local selectedWorkTreeDir=$(git worktree list | fzf | awk '{print $1}')

  if [ "$selectedWorkTreeDir" = "" ]; then
    # Ctrl-C.
    return
  fi

  cd ${selectedWorkTreeDir}
}

## ghq-fzf #{{{1
function ghq-fzf() {
  local src=$(ghq list | fzf --preview "ls -laTp $(ghq root)/{} | tail -n+4 | awk '{print \$9\"/\"\$6\"/\"\$7 \" \" \$10}'")
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle -R -c
}
zle -N ghq-fzf
bindkey '^]' ghq-fzf

## gget #{{{1
gget() {
  if [[ -z $1 ]]; then
    echo "usage: gget <repo>"
    return 1
  fi

  local dir
  dir=$(ghq list -p "$1" 2>/dev/null)

  # まだ無ければ clone
  if [[ -z $dir ]]; then
    ghq get "$1" || return
    dir=$(ghq list -p "$1") || return
  fi

  cd "$dir" || exit
}

## ssm #{{{1
function ssm() {
  local profile selected instance_id

  # 引数があればそれ、なければfzfで選択
  if [ -n "$1" ]; then
    profile="$1"
  else
    profile=$(aws configure list-profiles | fzf --prompt="profile > ")
  fi

  [ -z "$profile" ] && return

  selected=$(aws ec2 describe-instances \
    --profile "$profile" \
    --filters "Name=instance-state-name,Values=running" \
    --query "Reservations[].Instances[].{id:InstanceId,name:Tags[?Key=='Name']|[0].Value,ip:PrivateIpAddress}" \
    --output text \
    | awk '{printf "%-20s %-30s %s\n", $1, $2, $3}' \
    | fzf --prompt="instance > ")

  [ -z "$selected" ] && return

  instance_id=$(echo "$selected" | awk '{print $1}')

  aws ssm start-session --target "$instance_id" --profile "$profile"
}

## _tmuxpopup #{{{1
# https://blog.monochromegane.com/blog/2026/01/11/popup/
autoload -Uz _tmuxpopup
autoload -Uz _tmuxpopup-claude
autoload -Uz _tmuxpopup-copilot

function _tmuxpopup() {
  local initial_cmd="${1:-}"
  local title="${2:-}"

  local width='80%'
  local height='80%'

  local session
  session="$(tmux display-message -p -F '#{session_name}' 2>/dev/null)" || return 1

  local pane_path
  pane_path="$(tmux display-message -p -F '#{pane_current_path}')" || return 1

  local home_src="${HOME}/src"
  local key=""

  if [[ $pane_path == ${home_src}/*/*/*(|/*) ]]; then
    local rest="${pane_path#${home_src}/}"
    local parts=(${(s:/:)rest})
    local org="${parts[2]}"
    local repo="${parts[3]}"
    repo="${repo%-wt}"
    key="${org}/${repo}"
  else
    key="${pane_path:t}"
  fi

  local safe_key="${key//\//_}"
  safe_key="${safe_key//[^A-Za-z0-9_.-]/_}"

  local popup_session="popup_${title}_${safe_key}"

  if [[ $session == popup_* ]]; then
    tmux detach-client
    return 0
  fi

  local exec_cmd
  if [[ -n $initial_cmd ]]; then
    exec_cmd="tmux attach -t ${popup_session} || tmux new -s ${popup_session} '${initial_cmd}'"
  else
    exec_cmd="tmux attach -t ${popup_session} || tmux new -s ${popup_session}"
  fi

  tmux display-popup \
    -d "#{pane_current_path}" \
    -xC -yC \
    -w "$width" -h "$height" \
    -T "$title" \
    -E "$exec_cmd"
}

function _tmuxpopup-claude() {
  _tmuxpopup "claude" "claude"
}

function _tmuxpopup-copilot() {
  _tmuxpopup "copilot" "copilot"
}

# vim: ft=sh fdm=marker
