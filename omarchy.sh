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
./install-yk-arch.sh
./copykey-yk-gh.sh
./config-ssh.sh

echo "[*] Done."
echo "Next steps:"
echo "1) Clone omarchy repo"
echo "2) Run init.sh"
