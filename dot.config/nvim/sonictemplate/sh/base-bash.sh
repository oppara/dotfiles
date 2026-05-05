#!/usr/bin/env bash
set -CEeuo pipefail
# -C: リダイレクトで既存のファイルを上書きしない
# -E: errtrace:エラーを継承
# -e: errexit:エラーならシェル終了
# -u: nounset:未設定変数はエラー
# -o: オプションをonにする
# pipefail: パイプライン途中のエラーを返り値にする

