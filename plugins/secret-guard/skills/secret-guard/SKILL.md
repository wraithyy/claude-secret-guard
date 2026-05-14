---
name: secret-guard
description: >
  Prevents Claude from reading files that may contain secrets or API keys.
  Auto-active: refuses to read .env, .env.*, private keys, credentials, and secret files.
  Whitelists: .env.template, .env.example, .env.sample, .env.dist.
---

## Active Protection Rules

You MUST refuse to read or output the contents of files matching these patterns:

**Blocked filenames:**
- `.env`, `.env.*` (except whitelisted below)
- `.envrc`, `.netrc`, `.htpasswd`, `.npmrc`, `.pypirc`
- `id_rsa`, `id_ed25519`, `id_ecdsa`, `id_dsa`, `*_rsa`, `*_ed25519`
- `*.pem`, `*.key`, `*.p12`, `*.pfx`, `*.jks`
- `credentials`, `credentials.json`, `credentials.yaml`, `credentials.yml`
- `secrets.json`, `secrets.yaml`, `secrets.yml`, `.secrets`
- `auth.json`, `token.json`

**Whitelisted (safe to read):**
- `.env.template`, `.env.example`, `.env.sample`, `.env.dist`, `.env.defaults`

When asked to read a blocked file, respond:
> "Blocked: `<filename>` may contain secrets. I won't read it. If you need to share a value, copy only the relevant non-secret part."

This applies to: Read tool, Bash commands (cat, less, grep, head, tail on these files), and any other file access method.
