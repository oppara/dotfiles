#!/bin/bash
INPUT=$(cat)

MODEL=$(echo "$INPUT" | jq -r '.model.display_name // "Claude"')
DIR=$(echo "$INPUT" | jq -r '.workspace.current_dir // ""')
INPUT_TOKENS=$(echo "$INPUT" | jq -r '.context_window.total_input_tokens // 0')
OUTPUT_TOKENS=$(echo "$INPUT" | jq -r '.context_window.total_output_tokens // 0')
USED_PCT=$(echo "$INPUT" | jq -r '.context_window.used_percentage // 0')
DURATION_MS=$(echo "$INPUT" | jq -r '.cost.total_api_duration_ms // 0')

LATENCY=$(awk -v ms="$DURATION_MS" 'BEGIN { printf "%.1f", ms / 1000 }')

# $HOMEが未設定な環境で呼ばれても home dir を解決できるようにする
HOME_DIR="${HOME:-$(cd ~ 2>/dev/null && pwd)}"
DIR_DISPLAY="$DIR"
[ -n "$HOME_DIR" ] && DIR_DISPLAY="${DIR/#$HOME_DIR/"~"}"

printf '%s | %s/%s tokens | Context: %s%% used | %ss | %s\n' \
  "$MODEL" "$INPUT_TOKENS" "$OUTPUT_TOKENS" "$USED_PCT" "$LATENCY" "$DIR_DISPLAY"
