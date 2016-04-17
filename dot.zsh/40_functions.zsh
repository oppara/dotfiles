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

## mcd mkdir + cd #{{{1
function mcd() {
    [ -n "$1" ] && mkdir -p "$@" && cd "$1";
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


## sheet  #{{{1
# http://blog.glidenote.com/blog/2012/04/16/sheet/
compdef _sheets sheet
function _sheets {
  local -a cmds
  _files -W  ~/.sheets/ -P '~/.sheets/'

  cmds=('list' 'edit' 'copy')
  _describe -t commands "subcommand" cmds

  return 1;
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