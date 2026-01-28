#!/usr/bin/env bash
set -euo pipefail

CONFIG_FILE="$HOME/.ssh/config"
mkdir -p "$HOME/.ssh"

# Backup existing config if any
if [[ -f "$CONFIG_FILE" ]]; then
  cp "$CONFIG_FILE" "${CONFIG_FILE}.bak.$(date +%s)"
fi

# Collect all SSH keys containing '_gh' in filename (exclude pub files)
keys=()
while IFS= read -r -d $'\0' file; do
  keys+=("$file")
done < <(find "$HOME/.ssh" -maxdepth 1 -type f -name '*_gh*' ! -name '*.pub' -print0)

{
  echo "Host github.com"
  for key in "${keys[@]}"; do
    echo "  IdentityFile $key"
  done
  echo "  IdentitiesOnly yes"
  echo "  User git"
  echo "  HostName github.com"
} > "$CONFIG_FILE"
