#!/bin/bash
INPUT=$(cat)
MODEL=$(echo "$INPUT" | jq -r '.model.display_name')
DIR=$(echo "$INPUT" | jq -r '.workspace.current_dir')
printf '\033[2m%s\033[0m in \033[2m%s\033[0m\n' "$MODEL" "$DIR"
