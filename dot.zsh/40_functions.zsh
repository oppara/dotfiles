## sudo  #{{{1
# http://blog.monoweb.info/article/2011120320.html
sudo() {
  local args
  case $1 in
    v|vi|vim)
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

## ssh  #{{{1
# http://qiita.com/shrkw/items/167be53796d4507c736b
function ssh() {
  if [[ -n $(printenv TMUX) ]]
  then
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
# http://gitignore.io/cli
function gitignore() {
    curl "http://www.gitignore.io/api/$@";
}

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
    [ -n "$1" ] && mkdir -p -- "$1" && cd -P -- "$1";
}

# cd to the path of the front Finder window #{{{1
# http://blog.glidenote.com/blog/2013/02/26/jumping-to-the-finder-location-in-terminal/
cdf() {
  target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
  if [ "$target" != "" ]; then
    cd "$target"; pwd
  else
    echo 'No Finder window found' >&2
  fi
}


## checker for colors for .zshrc #{{{1
function pcolor() {
  for ((f = 0; f < 255; f++)); do
    printf "\e[38;5;%dm %3d\e[m" $f $f
    if [[ $f%8 -eq 7 ]] then
      printf "\n"
    fi
  done
  echo
}

# vim: ft=sh fdm=marker
