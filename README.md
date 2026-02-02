# Auth guide for YubiKey (SSH, GitHub)

## Install YubiKey software (Arch btw)

```bash
install-yk-arch.sh
```

This script installs all the necessary packages to use a YubiKey on an Arch-based Linux system.

## Generating new keys

```bash
new-ssh-gh.sh
```
This script generates a simple SSH key pair (non–hardware-backed).  
I use this for GitHub as well when I don’t want to use the YubiKey all the time.

```bash
new-yk-gh.sh
```
DANGER: You will lose your current FIDO2 key and all access associated with it.

This script generates a new FIDO2 key on the YubiKey.  
The public key can be added to GitHub to authenticate Git operations.  
The private key is only a stub that redirects requests to the YubiKey.  

## Using existing keys

```bash
copykey-yk-gh.sh
```
This script is similar to `new-yk-fido2.sh`, but it does not wipe the FIDO2 key stored on the YubiKey.  
It simply recreates the key pair on disk.

Use this when setting up a new system with an existing YubiKey.

```bash
config-ssh.sh
```

Creating key pairs alone is not enough for authentication.  
The system does not know where the keys are stored or which ones to use.  
This script creates an SSH config file that uses the already generated keys.  

NOTE: This is a very stupid script and it will overwrite your current SSH config file.  
Use it only when setting up a new system and no other keys have been configured manually.

## Omarchy for me

DO NOT USE THIS, this one is for me because I'm lazy :)

```bash
curl -fsSL https://raw.githubusercontent.com/redcoreit/auth/master/omarchy.sh > ./omarchy.sh && chmod 744 ./omarchy.sh && ./omarchy.sh
```
