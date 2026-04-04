#!/bin/bash
# CloudFormation IaC Generatorがサポートするリソースタイプ一覧を取得する
# 使い方: ./list_importable_resources.sh [フィルタ文字列]
# 例: ./list_importable_resources.sh AWS::S3
# 必要条件: AWS CLI v2、jq

set -CEeuo pipefail

FILTER="${1:-}"

# サポート対象リソースタイプを取得（AWS管理のパブリックタイプ）
TYPES=$(aws cloudformation list-types \
  --type RESOURCE \
  --visibility PUBLIC \
  --filters Category=AWS_TYPES \
  --query 'TypeSummaries[].TypeName' \
  --output json 2>/dev/null)

if [ -z "$TYPES" ] || [ "$TYPES" = "null" ]; then
  echo "リソースタイプの取得に失敗しました。AWS認証情報とリージョン設定を確認してください。" >&2
  exit 1
fi

TOTAL=$(echo "$TYPES" | jq 'length')

if [ -n "$FILTER" ]; then
  echo "$TYPES" | jq -r ".[] | select(contains(\"$FILTER\"))" | sort
  MATCHED=$(echo "$TYPES" | jq "[.[] | select(contains(\"$FILTER\"))] | length")
  echo "" >&2
  echo "一致: ${MATCHED} / 合計: ${TOTAL} タイプ（フィルタ: ${FILTER}）" >&2
else
  echo "$TYPES" | jq -r '.[]' | sort
  echo "" >&2
  echo "合計: ${TOTAL} タイプ" >&2
fi
