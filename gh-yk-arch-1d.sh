#!/usr/bin/env bash
set -euo pipefail

VAR_LINE='export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"'
BASHRC="$HOME/.bashrc"

# add to ~/.bashrc if missing
if ! grep -Fxq "$VAR_LINE" "$BASHRC" 2>/dev/null; then
  echo "Adding SSH_AUTH_SOCK to $BASHRC"
  echo "" >> "$BASHRC"
  echo "$VAR_LINE" >> "$BASHRC"
fi

# export for current session
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# ensure agent is running
systemctl --user enable --now ssh-agent.service

# add key with 1 day TTL
ssh-add -t 1d ~/.ssh/id_ed25519_sk_github
