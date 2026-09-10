## git状態セグメント #{{{1
# git status --porcelain=v2 --branch --show-stash を1回叩くだけで
# ブランチ名・stash数・staged/modified/untracked/conflictの件数を
# まとめて取得できる(gitリポジトリ以外では早期return)
_opp_prompt_git_segment() {
  local raw
  raw=$(git status --porcelain=v2 --branch --show-stash 2>/dev/null)
  (( $? )) && return

  local branch="" line xy
  local -i staged=0 modified=0 untracked=0 conflict=0 stash=0

  while IFS= read -r line; do
    case "$line" in
      '# branch.head '*) branch=${line#'# branch.head '} ;;
      '# stash '*)       stash=${line#'# stash '} ;;
      '1 '*|'2 '*)
        xy=${line#* }
        xy=${xy%% *}
        [[ ${xy:0:1} != '.' ]] && (( staged++ ))
        [[ ${xy:1:1} != '.' ]] && (( modified++ ))
        ;;
      'u '*) (( conflict++ )) ;;
      '?'*)  (( untracked++ )) ;;
    esac
  done <<< "$raw"

  [[ $branch == '(detached)' ]] && branch=$(git rev-parse --short HEAD 2>/dev/null)

  local branch_color=green
  (( staged > 0 )) && branch_color=yellow
  (( modified > 0 || conflict > 0 )) && branch_color=red

  local seg=" %F{$branch_color} ${branch}%f"
  (( staged    > 0 )) && seg+=" %F{yellow}+${staged}%f"
  (( modified  > 0 )) && seg+=" %F{red}!${modified}%f"
  (( conflict  > 0 )) && seg+=" %F{red}U${conflict}%f"
  (( untracked > 0 )) && seg+=" %F{white}?${untracked}%f"
  (( stash     > 0 )) && seg+=" %F{cyan}*${stash}%f"
  print -n "$seg"
}

## AWSプロファイルセグメント #{{{1
_opp_prompt_aws_segment() {
  [[ -n $AWS_PROFILE ]] && print -n " %F{214}☁️ ${AWS_PROFILE}%f"
}

## precmdフックでPROMPTを組み立てる #{{{1
_opp_precmd() {
  local exit_code=$?
  local arrow_color=white
  (( exit_code != 0 )) && arrow_color=red

  local git_seg aws_seg
  git_seg=$(_opp_prompt_git_segment)
  aws_seg=$(_opp_prompt_aws_segment)

  PROMPT="%F{yellow}%~%f${git_seg}${aws_seg}
%F{${arrow_color}}❯%f "
}

add-zsh-hook precmd _opp_precmd

# vim: ft=zsh fdm=marker
