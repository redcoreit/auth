# Yubikey cheatsheet and scripts

## Linux

## That other thing from Redmond


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
