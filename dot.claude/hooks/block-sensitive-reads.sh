#!/bin/bash
INPUT=$(cat)
CMD=$(echo "$INPUT" | jq -r '.tool_input.command // empty')
[ -z "$CMD" ] && exit 0

SENSITIVE_PATTERNS='\.env|\.pem|\.key|id_rsa|id_ed25519|credentials|\.gnupg|\.aws|\.config/gcloud|\.bash_history|\.zsh_history'
if echo "$CMD" | grep -iqE "(cat|less|more|head|tail|grep|awk|sed|bat)\s.*(${SENSITIVE_PATTERNS})"; then
  echo "Blocked: reading sensitive file via Bash: $CMD" >&2
  exit 2
fi
exit 0
