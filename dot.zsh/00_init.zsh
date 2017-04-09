HISTFILE="${HOME}/.zsh-history"

## 重複したパスを登録しない
typeset -U path cdpath fpath manpath


## 補完機能の強化
# brew info zsh-completions
fpath=( \
    $(brew --prefix)/share/zsh-completions \
    $fpath \
    )

autoload -Uz compinit && compinit -u
autoload -Uz add-zsh-hook
autoload -Uz colors && colors


# キーバインド
## 設定しないと環境変数 EDITORやVISUALを参照するので設定
bindkey -e



## zsh の開始, 終了時刻をヒストリファイルに書き込む
setopt extended_history
## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups
## ヒストリを共有
setopt share_history
## ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_all_dups
## スペースで始まるコマンドラインはヒストリに追加しない。
setopt hist_ignore_space
## ヒストリは含まない
setopt hist_no_store
## 古いコマンドと同じものは無視
setopt hist_save_no_dups
## ヒストリを呼び出してから実行する間に一旦編集
setopt hist_verify
## 余分な空白は詰めて記録
setopt hist_reduce_blanks
## 補完時にヒストリを自動的に展開
setopt hist_expand
## 履歴をインクリメンタルに追加
setopt inc_append_history
## C-sでのヒストリ検索が潰されてしまうため、出力停止・開始用にC-s/C-qを使わない。
setopt no_flow_control

## ディレクトリ名だけで cd
setopt auto_cd

## cd 時に自動で push
setopt autopushd

## 同じディレクトリを pushd しない
setopt pushd_ignore_dups

## ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
setopt extended_glob

## TAB で順に補完候補を切り替える
setopt auto_menu

## スペルチェック
setopt correct

## ビープを鳴らさない
setopt nobeep
setopt nolistbeep

## 補完候補を詰めて表示
setopt list_packed


## コアダンプサイズを制限
limit coredumpsize 102400

## 出力の文字列末尾に改行コードが無い場合でも表示
unsetopt promptcr

## PROMPT 変数の中の変数参照をプロンプト表示時に展開
setopt prompt_subst



## 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt long_list_jobs

## 補完候補一覧でファイルの種別をマーク表示
setopt list_types

## サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt auto_resume

## 補完候補を一覧表示
setopt auto_list


## =command を command のパス名に展開する
setopt equals

## --prefix=/usr などの = 以降も補完
setopt magic_equal_subst



# ファイル名の展開で辞書順ではなく数値的にソート
setopt numeric_glob_sort

## 出力時8ビットを通す
setopt print_eight_bit

## カッコの対応などを自動的に補完
setopt auto_param_keys

## ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash


# vim: ft=sh fdm=marker
