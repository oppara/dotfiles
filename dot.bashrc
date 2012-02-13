ulimit -c 0  # Don't create core dumps

export LANG=ja_JP.UTF-8
#export LANG=ja_JP.eucJP

export LV='-Ou8'

#export PROMPT_COMMAND 'echo -ne "\033k[$(PWD | sed "s#^$HOME#\~#;s#^\(\~*/[^/]*/\).*\(/[^/]*\)#\1...\2#")]\033\\"'
export PROMPT_COMMAND='echo -ne "\033]0;$PWD\007"'
#
# path
#
# デフォルトのperlを使用するため/usr/local/binを先に設定する
export PATH=~/bin:\
/usr/local/bin:\
/usr/local/php/bin:\
/usr/local/mysql/bin:\
/usr/local/pgsql/bin:\
/usr/local/mtasc:\
/opt/local/bin:\
/Developer/Tools:\
/usr/local/sbin:\
/usr/bin:/usr/sbin:\
/bin:/sbin:\
$PATH

#function pmver() {perl -M$1 -le "print $1->VERSION";}


export PS1='\[\]\u > \w\n\$ '

export CDPATH=:~/Sites

alias vi='/opt/local/bin/vim'
alias vim='/opt/local/bin/gvim -p'
#/Applications/MacPorts/Vim/Vim.app/Contents/MacOS/Vim
#alias vim='~/bin/gvim --remote-tab-silent'

export SVN_EDITOR='/opt/local/bin/vim'
export EDITOR='/opt/local/bin/vim'

# http://d.hatena.ne.jp/kasahi/20070529/1180450135
# export SCREENDIR="~/.screen"

# mate - `~/bin/mate_conv.pl -i son.txt`
# alias mate='~/bin/mate -r'

alias perldoc='/usr/bin/perldoc '

# javascript lint
alias jsl='~/bin/jsl -conf ~/bin/jsl.default.conf -process'

# YUI Compressor
alias com='java -jar ~/bin/yuicompressor.jar'


# i19n manをインストールした場合
#alias man='LANG=ja_JP.UTF-8 /usr/bin/man'
#export MANPAGER="/usr/local/i18nman/bin/lv -c -Iu8"
#export LV="-Oe"


# perl -MConfig -MExtUtils::Install -e '($FULLEXT="XML-RSS";$FULLEXT=shift)=~s{-}{/}g;uninstall "$Config{sitearchexp}/auto/$FULLEXT/.packlist", 1'"'" 


# http://d.hatena.ne.jp/holidays-l/20070601/p1
alias cpan-uninstall='perl -MConfig -MExtUtils::Install -e '"'"'($FULLEXT=shift)=~s{-}{/}g;uninstall "$Config{sitearchexp}/auto/$FULLEXT/.packlist",1'"'"


#
# emacs
#
function myemacs
{
    stty raw;
    emacs $1 $2;
    stty -raw;
}
alias emacs="myemacs"

#
# `ls`の出力のカラー設定
#
export CLICOLOR=YES
#
# a     black
# b     red
# c     green
# d     brown
# e     blue
# f     magenta
# g     cyan
# h     light grey
# A     bold black, usually shows up as dark grey
# B     bold red
# C     bold green
# D     bold brown, usually shows up as yellow
# E     bold blue
# F     bold magenta
# G     bold cyan
# H     bold light grey; looks like bright white
# x     default foreground or background
# 大文字小文字関係なし。２文字一組。フォアグランドカラー、バックグラウンドカラーの組み合わせ。
# よくわからんものは、赤緑にしている
#
export LSCOLORS=GxCxBCBCBdBCBCBhBCBCEd

# 1.   directory
# 2.   symbolic link
# 3.   socket
# 4.   pipe
# 5.   executable
# 6.   block special
# 7.   character special
# 8.   executable with setuid bit set
# 9.   executable with setgid bit set
# 10.  directory writable to others, with sticky bit
# 11.  directory writable to others, without stickybit
# 
# cvs
#
export CVSROOT=${HOME}/cvsroot
#export CVSROOT=:pserver:oppara@127.0.0.1:/Users/oppara/cvsroot
#export CVSROOT=:pserver:oohara@192.9.200.13:/Volumes/devsrv/cvsroot

# 
# java
#
export JAVA_HOME=/Library/Java/Home

# ant
#export ANT_HOME=/Developer/Java/J2EE/Ant
#export PATH="${ANT_HOME}"/bin:"${PATH}"

#jmeter
#export JMETER_HOME=/Developer/Java/J2EE/JMeter
#export PATH="${JMETER_HOME}"/bin:"${PATH}"


#ImageMagick
#export PATH; PATH="$HOME/bin/ImageMagick/bin:$PATH"
#export DYLD_LIBRARY_PATH="$HOME/bin/ImageMagick-6.2.1/lib"

## タイトルに現在のディレクトリを表示
# case $TERM in              
# #         xterm*|rxvt*|Eterm)
# #         PROMPT_COMMAND='echo -ne "\033]0;[$(pwd | sed "s#^$HOME#\~#;s#^\(\~*/[^/]*/\).*\(/[^/]*\)#\1...\2#")]\007"'
# #         #PROMPT_COMMAND='echo -ne "\033]0;[$(pwd | sed "s#^$HOME#\~#;")]\007"'
# #         ;;
#         screen)
#         PROMPT_COMMAND='echo -ne "\033k[$(pwd | sed "s#^$HOME#\~#;s#^\(\~*/[^/]*/\).*\(/[^/]*\)#\1...\2#")]\033\\"'
#         ;;
# esac
# PROMPT_COMMAND='echo -ne "\033]0;$(whoami)@$(hostname):$(pwd)\007"'

