#!/bin/bash
INPUT=$(cat)
CMD=$(echo "$INPUT" | jq -r '.tool_input.command // empty')
[ -z "$CMD" ] && exit 0

# テンプレート用ファイルは機密ではない
CMD_CHECK=${CMD//.env.example/}
CMD_CHECK=${CMD_CHECK//.env.sample/}
CMD_CHECK=${CMD_CHECK//.env.template/}

READERS='cat|less|more|head|tail|grep|rg|awk|sed|bat|nl|cut|sort|strings|xxd|od|jq|yq|cp|mv|base64|source|xargs|\.'
Q="[\"']"
HEAD="(^|[;&|(\`]|\\\$\\()[[:space:]]*($READERS)[[:space:]]"
BOUNDARY="[/[:space:]=<]|$Q"
END="($|[[:space:];&|)<>]|$Q)"
NAMES='\.env(\.[A-Za-z0-9_-]+)?|[^/[:space:]]*\.(pem|key)|id_rsa|id_ed25519|credentials[^/[:space:]]*|\.netrc|\.git-credentials|\.bash_history|\.zsh_history'
DIRS='\.(gnupg|aws|ssh)|\.config/(gcloud|gh)'
SENSITIVE="((${NAMES})${END}|(${DIRS})(/|${END}))"

if echo "$CMD_CHECK" | grep -iqE "${HEAD}([^;&|]*(${BOUNDARY}))?${SENSITIVE}"; then
  echo "Blocked: reading sensitive file via Bash: $CMD" >&2
  exit 2
fi
if echo "$CMD_CHECK" | grep -iqE "<[[:space:]]*([^[:space:];&|]*/)?${SENSITIVE}"; then
  echo "Blocked: reading sensitive file via Bash: $CMD" >&2
  exit 2
fi
exit 0
