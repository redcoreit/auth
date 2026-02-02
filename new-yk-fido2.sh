#!/usr/bin/env bash
set -euo pipefail

while true; do
    echo "YubiKey FIDO2 wipe will be performed."
    echo "You lose all access to current FIDO2 protected sites."
    read -r -p "Proceed [y/n]: " ans
    case "$ans" in
        [Yy]|[Yy][Ee][Ss]) break ;;
        [Nn]|[Nn][Oo]) exit 1 ;;
        *) echo "Answer y or n." ;;
    esac
done

echo "[*] Creating SSH directory..."
mkdir -p ~/.ssh
chmod 700 ~/.ssh

KEY_PATH="$HOME/.ssh/id_ed25519_yk_gh"

if [[ ! -f "${KEY_PATH}" ]]; then
  echo "[*] Generating hardware-backed SSH key (touch required)..."
  ssh-keygen \
    -t ed25519-sk \
    -O resident \
    -O verify-required \
    -C "yubikey-github" \
    -f "${KEY_PATH}"
else
  echo "[*] SSH key already exists, skipping generation."
fi

chmod 600 "${KEY_PATH}"
chmod 644 "${KEY_PATH}.pub"

echo "[*] Public key to add to GitHub:"
echo "--------------------------------------------------"
cat "${KEY_PATH}.pub"
echo "--------------------------------------------------"

echo "[*] Done."
echo "Next steps:"
echo "1) Add the above SSH key to GitHub"
