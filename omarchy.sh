#!/usr/bin/env bash
set -euo pipefail

echo "[*] Bootstrapping Omarchy..."

# Setup dirs
BASE_DIR="$HOME/repos"
mkdir -p "$BASE_DIR"

# Get auth stuff, we need interactive shell, no curl
# No SSH without keys so only https remains
echo "[*] Cloning auth repo..."
cd "$BASE_DIR"
rm -rf auth_tmp > /dev/null
git clone https://github.com/redcoreit/auth.git auth_tmp

# Setup YubiKey and SSH access
cd "$BASE_DIR/auth_tmp"
./copykey-yk-gh.sh
./config-ssh.sh

# Get the secret goodies
echo "[*] Cloning omarchy repo..."
cd "$BASE_DIR"
git clone git@github.com:redcoreit/omarchy

# 'And the monkey presses the button.'
cd "$BASE_DIR/omarchy"
./init.sh


