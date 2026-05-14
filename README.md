# secret-guard

Claude Code plugin that prevents Claude from reading files containing secrets and API keys.

## What it does

**Soft protection (always active via skill):** Claude refuses to read sensitive files based on instructions.

**Hard protection (hook):** PreToolUse hook blocks `Read` and `Bash` tools at the OS level before execution. Registered automatically on first session after install.

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

Restart Claude Code. On the next session start, the hard-enforcement PreToolUse hook is registered automatically in `~/.claude/settings.json`.

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
| Hard | PreToolUse hook blocks Read + Bash tools | From next session after install |

The `SessionStart` hook runs `setup.sh` on each session. It detects if the PreToolUse entries are missing from `~/.claude/settings.json` and adds them (idempotent — runs once, then skips).
