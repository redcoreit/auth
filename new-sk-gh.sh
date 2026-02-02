#!/usr/bin/env bash
set -euo pipefail

echo "[*] Creating SSH directory..."
mkdir -p ~/.ssh
chmod 700 ~/.ssh

KEY_PATH="$HOME/.ssh/id_ed25519_sk_gh"

if [[ ! -f "${KEY_PATH}" ]]; then
  echo "[*] Generating SSH key for GitHub repo access"
  ssh-keygen \
    -t ed25519-sk \
    -C "github" \
    -f "${KEY_PATH}"
else
  echo "[*] SSH key already exists, skipping generation."
fi

echo "[*] Public key to add to GitHub:"
echo "--------------------------------------------------"
cat "${KEY_PATH}.pub"
echo "--------------------------------------------------"

echo "[*] Done."
echo "Next steps:"
echo "1) Add the above SSH key to GitHub"
echo "2) Check ssh-agent running: echo $SSH_AUTH_SOCK"
