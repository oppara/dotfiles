---
name: cfn-resource-import
description: CloudFormation IaC Generatorを活用し、既存AWSリソースの検出からCloudFormationスタックへのインポートまでを行うスキル。手動作成リソースのIaC管理化、インフラ棚卸し、複数リージョンにまたがるリソース検出に使用する。
metadata:
  version: "0.1.0"
compatibility: AWS CLI v2、jq が必要。AWSアカウントへの適切な権限（CloudFormation、対象リソースの読み取り権限）が必要。
---

# CloudFormation リソースインポート（IaC Generator活用）

CloudFormation IaC Generatorを使って既存AWSリソースを検出し、CloudFormationスタックとして管理下に取り込む。

## 使用場面

- 手動で作成したリソースをCloudFormation管理下に取り込む
- 既存クラウドインフラの棚卸し・監査
- 複数リージョンにまたがるリソースの検出
- 手動プロビジョニングからIaCへの移行

## 重要: まずサポート確認を行うこと

**作業開始前に、対象リソースタイプがIaC Generatorに対応しているか必ず確認する：**

```bash
./scripts/list_importable_resources.sh
# または特定のリソースタイプを絞り込む場合
./scripts/list_importable_resources.sh | grep "AWS::S3"
```

## 判断フロー

1. **対象リソースタイプを特定**（例: AWS::S3::Bucket、AWS::EC2::Instance）
2. **サポート確認**: `./scripts/list_importable_resources.sh` を実行
3. **ワークフロー選択**:
   - **対応している場合**: IaC Generator ワークフロー（以下）を使用
   - **対応していない場合**: 手動インポート手順（[references/MANUAL-IMPORT.md](references/MANUAL-IMPORT.md)）を参照

## IaC Generator ワークフロー

### ステップ1: リソーススキャン開始

```bash
# アカウント全体のリソーススキャンを開始
SCAN_ID=$(aws cloudformation start-resource-scan \
  --query 'ResourceScanId' \
  --output text)
echo "スキャンID: $SCAN_ID"

# スキャン完了を待機（COMPLETE になるまで数分かかる場合あり）
aws cloudformation describe-resource-scan \
  --resource-scan-id "$SCAN_ID" \
  --query 'Status'
```

### ステップ2: リソース一覧取得・絞り込み

```bash
# スキャン結果から対象リソースを絞り込む
aws cloudformation list-resource-scan-resources \
  --resource-scan-id "$SCAN_ID" \
  --resource-type-prefix "AWS::S3::Bucket"

# 特定タグでフィルタリング
aws cloudformation list-resource-scan-resources \
  --resource-scan-id "$SCAN_ID" \
  --resource-type-prefix "AWS::EC2::Instance" \
  --tag-key "Environment" \
  --tag-value "production"
```

### ステップ3: テンプレート生成

```bash
# テンプレート生成リクエスト
TEMPLATE_ID=$(aws cloudformation create-generated-template \
  --generated-template-name "my-import-template" \
  --resources '[
    {"ResourceType": "AWS::S3::Bucket", "ResourceIdentifier": {"BucketName": "my-bucket"}}
  ]' \
  --query 'GeneratedTemplateId' \
  --output text)

# 生成完了を待機
aws cloudformation describe-generated-template \
  --generated-template-name "my-import-template" \
  --query 'Status'

# テンプレートを取得・保存
aws cloudformation get-generated-template \
  --generated-template-name "my-import-template" \
  --query 'TemplateBody' \
  --output text > generated-template.yaml
```

### ステップ4: テンプレートのクリーンアップ

生成されたテンプレートにはすべての属性が含まれる。以下を実施してクリーンアップする：

1. **読み取り専用属性の除去** — ARN、CreationDate など計算済み属性を削除
2. **パラメータ化** — ハードコードされた値を `Parameters` セクションに切り出す
3. **命名整理** — リソース論理IDを意味のある名前に変更
4. **不要なデフォルト値の削除** — 明示的に設定不要なデフォルト値を削除

```yaml
# 生成直後（クリーンアップ前）
Resources:
  BucketABC123:
    Type: AWS::S3::Bucket
    Properties:
      BucketName: my-bucket
      CreationDate: "2024-01-01T00:00:00Z"  # 削除: 読み取り専用
      Arn: arn:aws:s3:::my-bucket           # 削除: 読み取り専用
      VersioningConfiguration:
        Status: Suspended                    # 削除: デフォルト値

# クリーンアップ後
Parameters:
  BucketName:
    Type: String
    Default: my-bucket

Resources:
  MyBucket:
    Type: AWS::S3::Bucket
    Properties:
      BucketName: !Ref BucketName
```

### ステップ5: インポート実行

```bash
STACK_NAME="my-stack"

# 新規スタックとしてインポートする場合
aws cloudformation create-change-set \
  --stack-name "$STACK_NAME" \
  --change-set-name "import-changeset" \
  --change-set-type IMPORT \
  --template-body file://generated-template.yaml \
  --resources-to-import '[
    {"ResourceType": "AWS::S3::Bucket", "LogicalResourceId": "MyBucket", "ResourceIdentifier": {"BucketName": "my-bucket"}}
  ]'

# チェンジセットの確認
aws cloudformation describe-change-set \
  --stack-name "$STACK_NAME" \
  --change-set-name "import-changeset"

# インポート実行
aws cloudformation execute-change-set \
  --stack-name "$STACK_NAME" \
  --change-set-name "import-changeset"

# 完了確認
aws cloudformation describe-stacks \
  --stack-name "$STACK_NAME" \
  --query 'Stacks[0].StackStatus'
```

## 複数リージョン対応

```bash
REGIONS=("ap-northeast-1" "us-east-1" "eu-west-1")

for REGION in "${REGIONS[@]}"; do
  echo "=== リージョン: $REGION ==="
  aws cloudformation start-resource-scan \
    --region "$REGION" \
    --query 'ResourceScanId' \
    --output text
done
```

## ベストプラクティス

### スキャン
- スキャンは同一アカウントで同時に1つのみ実行可能
- 大規模アカウントでは完了まで10〜30分かかる場合がある
- `--resource-type-prefix` で絞り込んでから処理すると効率的

### テンプレート管理
- インポート実行前に必ず `describe-change-set` で内容を確認する
- 生成コードはすべてレビューしてから適用する
- バージョン管理（Git）でテンプレートを管理する
- `Description` フィールドは必ず英語で記述する
- ファイルを作成する場合は、スキルを実行しているディレクトリ内に作成する

### インポート
- インポート対象リソースはすでに他のスタックで管理されていないことを確認する
- `DeletionPolicy: Retain` を設定してインポート中の誤削除を防ぐ

## トラブルシューティング

| 問題 | 対処法 |
|------|--------|
| スキャンが `FAILED` になる | IAM権限を確認。CloudFormation と対象リソースの読み取り権限が必要 |
| テンプレート生成が失敗する | リソースIDが正しいか確認。スキャン結果の `ResourceIdentifier` を使う |
| インポートでドリフト検出エラー | テンプレートの属性値が実際のリソース設定と一致しているか確認 |
| `IMPORT_ROLLBACK_COMPLETE` になる | チェンジセット内容を確認し、読み取り専用属性や不正な値を除去する |
| リソースタイプが非対応 | [references/MANUAL-IMPORT.md](references/MANUAL-IMPORT.md) の手動インポート手順を参照 |
