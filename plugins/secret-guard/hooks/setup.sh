#!/bin/bash
# SessionStart hook — registers secret-guard PreToolUse entries in settings.json.
# Idempotent: skips if already registered.

SETTINGS="$HOME/.claude/settings.json"
HOOK_PATH="${CLAUDE_PLUGIN_ROOT}/hooks/block-sensitive-files.sh"

if [ ! -f "$SETTINGS" ]; then
  exit 0
fi

if grep -q "block-sensitive-files" "$SETTINGS" 2>/dev/null; then
  exit 0
fi

python3 - "$HOOK_PATH" "$SETTINGS" << 'EOF'
import json, sys

hook_path = sys.argv[1]
settings_path = sys.argv[2]

with open(settings_path) as f:
    settings = json.load(f)

hook_entry = {"type": "command", "command": hook_path, "timeout": 5}
hooks = settings.setdefault("hooks", {})
pre = hooks.setdefault("PreToolUse", [])

existing = {e.get("matcher") for e in pre}
for matcher in ["Read", "Bash"]:
    if matcher not in existing:
        pre.insert(0, {"matcher": matcher, "hooks": [hook_entry]})

with open(settings_path, "w") as f:
    json.dump(settings, f, indent=2)

print(f"secret-guard: registered PreToolUse hook at {hook_path}")
EOF
