#!/bin/bash

pwd=`pwd`
dotfiles=$(ls |grep '^dot\.')

for file in $dotfiles
do

    org=${file}
    # osx用の設定
    if echo "$file" | grep 'mac\.' > /dev/null; then
        if [ "${OSTYPE%%[^a-z]*}" != 'darwin' ]; then
            continue
        fi
        file=${file/mac./}
    fi

    src="${pwd}/${org}"
    target="${HOME}/${file#dot}"

    # ファイルやディレクトリが存在する場合はスキップ
    if test -e "$target" && ! test -L "$target" ; then
        echo "file or directory already exists!! [${target}] "
        continue
    fi

    if test -L "$target" ; then
        rm "$target"
    fi

    ln -s "$src" "$target"
    echo "ln -s ${target}"

done

echo "done."
