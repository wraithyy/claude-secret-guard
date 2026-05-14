# secret-guard

Claude Code plugin that prevents Claude from reading files containing secrets and API keys.

## What it does

**Soft protection (always active via skill):** Claude refuses to read sensitive files based on instructions.

**Hard protection (hook):** PreToolUse hook that technically blocks `Read` and `Bash` tools before they execute — activates automatically on install.

### Blocked files

`.env`, `.env.*`, `.envrc`, `.netrc`, `id_rsa`, `id_ed25519`, `*.pem`, `*.key`, `*.p12`, `credentials.json`, `secrets.yaml`, and more.

### Whitelisted (always readable)

`.env.template`, `.env.example`, `.env.sample`, `.env.dist`

---

## Install

```bash
claude plugin marketplace add wraithyy/claude-secret-guard
claude plugin install secret-guard@claude-secret-guard
```

That's it. Both soft protection (skill) and hard enforcement (PreToolUse hook) activate automatically.

### Manual install (settings.json)

```json
{
  "extraKnownMarketplaces": {
    "claude-secret-guard": {
      "source": {
        "source": "github",
        "repo": "wraithyy/claude-secret-guard"
      }
    }
  },
  "enabledPlugins": {
    "secret-guard@claude-secret-guard": true
  }
}
```

---

## How it works

| Layer | Mechanism | Active |
|-------|-----------|--------|
| Soft | Skill instructs Claude to refuse reads | Always (via plugin skill) |
| Hard | PreToolUse hook blocks Read + Bash tools at OS level | Always (via plugin.json hook) |
