#!/usr/bin/env bash
set -euo pipefail

echo "[*] Creating SSH directory..."
mkdir -p ~/.ssh
chmod 700 ~/.ssh

KEY_PATH="$HOME/.ssh/id_ed25519_github"

if [[ ! -f "${KEY_PATH}" ]]; then
  echo "[*] Generating SSH key for GitHub repo access"
  ssh-keygen \
    -t ed25519-sk \
    -C "github" \
    -f "${KEY_PATH}"
else
  echo "[*] SSH key already exists, skipping generation."
fi

SSH_CONFIG="$HOME/.ssh/config"

if [[ ! -f "${SSH_CONFIG}" ]]; then
  chmod 600 "${KEY_PATH}"
  chmod 644 "${KEY_PATH}.pub"

  echo "[*] Configuring SSH for GitHub..."

  if ! grep -q "Host github.com" "${SSH_CONFIG}" 2>/dev/null; then
    cat >> "${SSH_CONFIG}" <<EOF

  Host github.com
    HostName github.com
    User git
    IdentityFile ${KEY_PATH}
    IdentitiesOnly yes
  EOF
  fi
else
  echo "${SSH_CONFIG} file already exists, please add the following line for github.com section."
  echo "  IdentityFile ${KEY_PATH}"
fi

chmod 600 "${SSH_CONFIG}"

echo "[*] Public key to add to GitHub:"
echo "--------------------------------------------------"
cat "${KEY_PATH}.pub"
echo "--------------------------------------------------"

echo "[*] Done."
echo "Next steps:"
echo "1) Add the above SSH key to GitHub"
echo "2) Check ssh-agent running: echo $SSH_AUTH_SOCK"
