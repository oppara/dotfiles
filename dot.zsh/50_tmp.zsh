
# https://qiita.com/greymd/items/ad18aa44d4159067a627
# usage:
#     $ pict test.txt| pict-format
alias pict-format="column -s$'\t' -t | tee >(sed -n '1,1p') | sed '1,1d' | sort"
