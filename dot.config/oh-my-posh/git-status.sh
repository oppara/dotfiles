#!/usr/bin/env bash

git rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0

branch=$(git branch --show-current)
status=$(git status --porcelain)

head_color="green"
untracked=""

while IFS= read -r line; do
  [[ -z $line ]] && continue

  index="${line:0:1}"
  worktree="${line:1:1}"

  # Untracked
  if [[ $line == "??"* ]]; then
    untracked="<white>?</>"
    continue
  fi

  # Working Tree
  case "$worktree" in
    M | D | R | C | U)
      head_color="red"
      ;;
  esac

  # Staging（Working が優先）
  if [[ $head_color != "red" ]]; then
    case "$index" in
      M | A | D | R | C | U)
        head_color="yellow"
        ;;
    esac
  fi
done <<<"$status"

printf "⣿ <%s>%s</>%s" \
  "$head_color" \
  "$branch" \
  "${untracked:+ $untracked}"
