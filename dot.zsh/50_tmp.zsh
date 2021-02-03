alias gg="_rgAndVim"
function _rgAndVim() {
    if [ -z "$1" ]; then
        echo 'Usage: gg PATTERN'
        return 0
    fi
    result=`rg -n --hidden $1 | fzf`
    line=`echo "$result" | awk -F ':' '{print $2}'`
    file=`echo "$result" | awk -F ':' '{print $1}'`
    if [ -n "$file" ]; then
        vim $file +$line
    fi
}

# https://qiita.com/greymd/items/ad18aa44d4159067a627
# usage:
#     $ pict test.txt| pict-format
alias pict-format="column -s$'\t' -t | tee >(sed -n '1,1p') | sed '1,1d' | sort"
