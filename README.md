# SOPS Client

### Reference

Use the Docker Base Image Embedded with `sops`


### Installation of `sops`

This guide can help you to install as a _binary_ or _build_ using _golang_

[Github Sops](https://github.com/mozilla/sops)

### Setup Key
```
gpg --batch --generate-key <<EOF
     %echo Generating MyGPG Key
     Key-Type: RSA
     Key-Length: 2048
     Subkey-Type: RSA
     Subkey-Length: 2048
     Name-Real: MY
     Name-Comment: MYEncryption Secret
     Name-Email: my@example.com
     Expire-Date: 0
     %no-ask-passphrase
     %no-protection
     %commit
     %echo done
EOF
```

### Create ASCII Armored Output
Public Key
```
gpg --armor --output my-public.asc --export my@example.com
```
Private Key
```
gpg --armor --output my-private.asc --export-secret-keys  my@example.com
```

### Importing to gpg keyring(local)

Public Key
```
gpg --import my-public.asc
```
Private Key
```
gpg --allow-secret-key-import --import my-private.asc
```

### SOPS Commands

Encrypt
```
sops --verbose --output "file.sops.encrypt" --encrypt "file.plaintext
```
Decrypt
```
sops --verbose --output "file.sops.decrypt" --decrypt "file.plaintext"
```

### Important Variables

 - SOPS_PGP_FP
 - GNUPGHOME

### Development

Want to contribute? Great!

 - Raise MR's with additional Improvements
