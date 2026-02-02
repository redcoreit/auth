#!/usr/bin/env bash
set -euo pipefail

while true; do
    echo "Installing YubiKey components..."
    read -r -p "Proceed [y/n]: " ans
    case "$ans" in
        [Yy]|[Yy][Ee][Ss]) break ;;
        [Nn]|[Nn][Oo]) exit 1 ;;
        *) echo "Answer y or n." ;;
    esac
done

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

echo "[*] Done."
