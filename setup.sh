#!/bin/sh

set -eu

create_symbolic_link() {
  local src="$1"
  local target="$2"

  if test -e "$target" && ! test -L "$target"; then
    echo "file or directory already exists!! [${target}] "
    continue
  fi

  if test -L "$target"; then
    rm "$target"
  fi

  ln -s "$src" "$target"
  echo "ln -s $src $target"
}

CURRENT=$(cd $(dirname $0) && pwd)

for file in $(ls "$CURRENT" | grep '^dot\.'); do
  org="$file"

  # osx用の設定
  if echo "$file" | grep 'mac\.' >/dev/null; then
    if [ "${OSTYPE%%[^a-z]*}" != 'darwin' ]; then
      continue
    fi

    file=${file/mac./}
  fi

  src="${CURRENT}/${org}"
  target="${HOME}/${file#dot}"

  create_symbolic_link "$src" "$target"
done

for dir in $(ls "${CURRENT}/config"); do
  src="${CURRENT}/config/${dir}"
  target="${HOME}/.config/${dir}"

  create_symbolic_link "$src" "$target"
done

if [ ! -e "${HOME}/.ssh/conf.d" ]; then
  mkdir -p "${HOME}"/.ssh/conf.d/{common,hosts}
fi

echo "done."
