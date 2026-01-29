#!/usr/bin/env bash
set -euo pipefail

echo "Bootstrapping Omarchy..."

# YOLO
curl -fsSL https://raw.githubusercontent.com/redcoreit/auth/master/yolo.sh | sh

# Setup dirs
BASE_DIR="$HOME/repos"
mkdir -p "$BASE_DIR"
cd "$BASE_DIR"

# Get the secret goodies
git clone git@github.com:redcoreit/omarchy

# 'And the monkey presses the button.'
cd "$BASE_DIR/omarchy"
./init.sh


