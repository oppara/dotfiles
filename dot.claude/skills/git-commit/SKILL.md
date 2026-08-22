---
name: git-commit
description: ステージ済みの変更を分析し、Conventional Commits形式でコミットするスキル。ブランチの同期確認・新規ブランチ作成の要否確認も行う。
---

# Git Commit

ステージ済みの変更を確認し、`dot.gitmessage` の規約に沿ったコミットメッセージを作成してコミットする。

## Step 1: ブランチ確認

1. 現在のブランチを取得: `git branch --show-current`
2. AskUserQuestionで確認: 「新しいブランチを作成しますか？」（デフォルト: いいえ）

## Step 2: リモートとの同期（自動）

1. `git fetch` でリモートを取得
2. リモートHEADと差分がある場合は自動で `git pull` を実行

## Step 3: ブランチ作成（要求された場合のみ）

1. `git diff --cached` でステージ済みの変更を分析
2. Conventional Commits形式でブランチ名を決定: `<type>/<short-description>`
3. `git checkout -b <branch-name>` を実行

## コミットワークフロー

1. `git diff --cached` でステージ済みの変更を分析
2. ステージ済みの変更が無い場合は、その旨を伝えて終了する
3. `git log` で直近のコミットスタイルを確認する
4. `git diff --cached` の内容に基づき、包括的なコミットメッセージを作成する
   - 形式: `<type>[(optional scope)]: <description>`
   - スコープは変更範囲が明確な場合のみ付ける（例: `fix(zsh): ...`, `feat(bash): ...`）。複数領域にまたがる、または明確なスコープが無い場合はスコープを省略する（例: `chore: ...`）
   - type は `dot.gitmessage` の定義に従う: `build` `chore` `ci` `config` `deps` `docs` `feat` `fix` `mv` `perf` `prune` `refactor` `release` `revert` `security` `style` `test` `typo`
   - 本文には変更点を箇条書きで記載する
   - 参考: https://www.conventionalcommits.org/ja/v1.0.0/
5. `git commit -m "message"` を実行する

## 制約

- `git add` は絶対に実行しない
- ステージ済みの変更のみを対象とする
