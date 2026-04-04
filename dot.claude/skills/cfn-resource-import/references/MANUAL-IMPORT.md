# 手動インポートリファレンス

IaC Generatorが非対応のリソースタイプ、またはより細かい制御が必要な場合に使用する。

## 1. AWS CLIでリソースを検出する

```bash
# EC2インスタンス
aws ec2 describe-instances \
  --query 'Reservations[].Instances[].InstanceId' \
  --output text

# RDSインスタンス
aws rds describe-db-instances \
  --query 'DBInstances[].DBInstanceIdentifier' \
  --output text

# DynamoDBテーブル
aws dynamodb list-tables \
  --query 'TableNames[]' \
  --output text

# S3バケット
aws s3api list-buckets \
  --query 'Buckets[].Name' \
  --output text

# Lambda関数
aws lambda list-functions \
  --query 'Functions[].FunctionName' \
  --output text

# SNSトピック
aws sns list-topics \
  --query 'Topics[].TopicArn' \
  --output text
```

## 2. CloudFormationテンプレートを手動作成する

```yaml
AWSTemplateFormatVersion: "2010-09-09"
Description: "手動インポート用テンプレート"

Parameters:
  BucketName:
    Type: String

Resources:
  MyBucket:
    Type: AWS::S3::Bucket
    DeletionPolicy: Retain  # インポート中の誤削除防止
    Properties:
      BucketName: !Ref BucketName
```

各リソースタイプで必要な `ResourceIdentifier` はAWSドキュメントまたは以下で確認する：

```bash
# リソースタイプのスキーマを確認（インポートIDキーが記載されている）
aws cloudformation describe-type \
  --type RESOURCE \
  --type-name AWS::S3::Bucket \
  --query 'Schema' \
  --output text | jq '.primaryIdentifier'
```

## 3. インポートの実行

### 新規スタックへのインポート

```bash
STACK_NAME="my-stack"
RESOURCE_TYPE="AWS::S3::Bucket"
LOGICAL_ID="MyBucket"
IDENTIFIER_KEY="BucketName"
IDENTIFIER_VALUE="my-existing-bucket"

aws cloudformation create-change-set \
  --stack-name "$STACK_NAME" \
  --change-set-name "manual-import" \
  --change-set-type IMPORT \
  --template-body file://template.yaml \
  --resources-to-import "[
    {
      \"ResourceType\": \"$RESOURCE_TYPE\",
      \"LogicalResourceId\": \"$LOGICAL_ID\",
      \"ResourceIdentifier\": {\"$IDENTIFIER_KEY\": \"$IDENTIFIER_VALUE\"}
    }
  ]" \
  --parameters "ParameterKey=BucketName,ParameterValue=$IDENTIFIER_VALUE"

# チェンジセット確認
aws cloudformation describe-change-set \
  --stack-name "$STACK_NAME" \
  --change-set-name "manual-import"

# 実行
aws cloudformation execute-change-set \
  --stack-name "$STACK_NAME" \
  --change-set-name "manual-import"
```

### 既存スタックへの追加インポート

```bash
aws cloudformation create-change-set \
  --stack-name "$STACK_NAME" \
  --change-set-name "add-import" \
  --change-set-type IMPORT \
  --template-body file://updated-template.yaml \
  --resources-to-import "[...]"
```

## 4. 複数リソースの一括インポートスクリプト例

```bash
#!/bin/bash
# bulk-import-s3.sh — 複数S3バケットを一括インポート

STACK_NAME="s3-import-stack"
TEMPLATE_FILE="s3-import.yaml"

# バケット一覧取得
BUCKETS=$(aws s3api list-buckets \
  --query 'Buckets[].Name' \
  --output text)

# テンプレート生成
cat > "$TEMPLATE_FILE" << 'EOF'
AWSTemplateFormatVersion: "2010-09-09"
Resources:
EOF

RESOURCES_TO_IMPORT="["
FIRST=true

for BUCKET in $BUCKETS; do
  LOGICAL_ID="Bucket${BUCKET//[-.]/_}"

  cat >> "$TEMPLATE_FILE" << EOF
  $LOGICAL_ID:
    Type: AWS::S3::Bucket
    DeletionPolicy: Retain
    Properties:
      BucketName: $BUCKET
EOF

  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    RESOURCES_TO_IMPORT+=","
  fi

  RESOURCES_TO_IMPORT+="{\"ResourceType\":\"AWS::S3::Bucket\",\"LogicalResourceId\":\"$LOGICAL_ID\",\"ResourceIdentifier\":{\"BucketName\":\"$BUCKET\"}}"
done

RESOURCES_TO_IMPORT+="]"

echo "生成されたテンプレート: $TEMPLATE_FILE"
echo "インポート対象リソース数: $(echo "$RESOURCES_TO_IMPORT" | jq length)"
echo ""
echo "次のコマンドを実行してインポートを開始してください:"
echo "aws cloudformation create-change-set \\"
echo "  --stack-name $STACK_NAME \\"
echo "  --change-set-name bulk-import \\"
echo "  --change-set-type IMPORT \\"
echo "  --template-body file://$TEMPLATE_FILE \\"
echo "  --resources-to-import '$RESOURCES_TO_IMPORT'"
```
