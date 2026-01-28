#!/usr/bin/env bash
set -euo pipefail

echo "[*] Installing required packages..."
sudo pacman -Sy --needed --noconfirm \
  yubikey-manager \
  yubikey-personalization \
  libfido2 \
  openssh \
  pcsclite

echo "[*] Enabling pcscd (smartcard service)..."
sudo systemctl enable --now pcscd.socket

echo "[*] Checking YubiKey..."
ykman info

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
echo "2) Add YubiKey as a passkey for GitHub web login"
