# secret-guard

Claude Code plugin that prevents Claude from reading files containing secrets and API keys.

## What it does

**Soft protection (always active via skill):** Claude refuses to read sensitive files based on instructions.

**Hard protection (hook):** PreToolUse hook that technically blocks `Read` and `Bash` tools before they execute.

### Blocked files

`.env`, `.env.*`, `.envrc`, `.netrc`, `id_rsa`, `id_ed25519`, `*.pem`, `*.key`, `*.p12`, `credentials.json`, `secrets.yaml`, and more.

### Whitelisted (always readable)

`.env.template`, `.env.example`, `.env.sample`, `.env.dist`

---

## Install

### 1. Add to Claude Code settings

Add to `~/.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "secret-guard": {
      "source": {
        "source": "github",
        "repo": "wraithyy/claude-secret-guard"
      }
    }
  },
  "enabledPlugins": {
    "secret-guard@secret-guard": true
  }
}
```

Or via Claude Code UI: open **Settings → Plugins**, add marketplace URL `wraithyy/claude-secret-guard`, then enable `secret-guard`.

### 2. Install the hook (hard enforcement)

In Claude Code, run:

```
/secret-guard-install
```

This writes `~/.claude/hooks/block-sensitive-files.sh` and configures `settings.json` automatically.

> **Note:** Step 1 enables the soft protection (skill-based). Step 2 adds hard enforcement via a PreToolUse hook that technically blocks the Read and Bash tools before execution. Both steps recommended.

---

## Skills

| Skill | Trigger | Purpose |
|-------|---------|---------|
| `secret-guard` | Auto-active | Soft protection via instructions |
| `secret-guard-install` | `/secret-guard-install` | Installs hard enforcement hook |
