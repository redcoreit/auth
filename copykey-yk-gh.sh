#!/usr/bin/env bash
set -euo pipefail

echo "[*] Getting YubiKey..."
ykman info

KEY_PATH="$HOME/.ssh/id_ed25519_yk_gh"

if [[ ! -f "${KEY_PATH}" ]]; then
  echo "[*] Regenerating hardware-backed SSH key (touch required)..."

  ssh-keygen -K
  mv id_ed25519_sk_rk "${KEY_PATH}"
  mv id_ed25519_sk_rk.pub "${KEY_PATH}.pub"
  chmod 600 "${KEY_PATH}"
  chmod 644 "${KEY_PATH}.pub"

  echo "[*] Done."
  echo "Next steps:"
  echo "1) Run config-ssh.sh"
else
  echo "[*] SSH key already exists, skipping generation."
fi

