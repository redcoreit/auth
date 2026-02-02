# Auth guide for GitHub using SSH and YubiKey

## Linux SSH setup

`gh-yk-arch.sh`

This script installs necessary components to use YubiKey with Arch linux.

`gh-sk-linux.sh`

Creates a new SSH key-pair, the classic way.

`config-ssh.sh`

Configures SSH keys to access GitHub.

`yolo.sh`

Calls gh-yk-arch.sh and config-ssh.sh

## GitHub SSH (one-time manual step)

- Copy the printed public key
- Go to: GitHub → Settings → SSH and GPG keys → New SSH key
- Paste it
- Test: `ssh -T git@github.com`

You should see:

```bash
Hi <username>! You've successfully authenticated...
```

Touch required. No passwords. Ever.

## GitHub web login, YubiKey as a Passkey (FIDO2)

1. GitHub → Settings → Password and authentication
1. Passkeys → Add passkey
1. Insert YubiKey
1. Touch when prompted

After this:

- Any modern browser (Firefox, Chromium)
- Login = insert key + touch

## YubiKey cheatsheet

### Generate RSA key on YubiKey

```bash
# generate, choose RSA 4096 or ECC (ed25519 / cv25519)
gpg --card-edit
admin
generate

# check key status
gpg --card-status
```

### Encrypt with YubiKey

```bash
gpg --encrypt --recipient YOUR_KEY_ID secret.txt
```

### Decrypt with YubiKey

```bash
gpg --decrypt secret.txt.gpg > secret.txt
```

## Omarchy for me

DO NOT USE THIS, this one is for me because I'm lazy :)

```bash
curl -fsSL https://raw.githubusercontent.com/redcoreit/auth/master/omarchy.sh > ./omarchy.sh && chmod 744 ./omarchy.sh && ./omarchy.sh
