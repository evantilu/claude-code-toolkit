# Claude Code Toolkit

A collection of development tools and utilities for enhancing Claude Code workflows across all projects.

## Overview

This toolkit contains reusable Claude Code extensions that improve productivity and workflow automation. Install once, use everywhere.

## Tools

### 📱 Notifications System

Push notifications to your iPhone when Claude Code gets blocked waiting for permissions.

**Features:**
- iPhone push notifications via ntfy.sh (free, no signup required)
- Configurable delay (default: 3 minutes) to avoid spam when actively working
- Generic messages for security (no command names or file paths leaked)
- Works across all your projects

**Location:** `dev-tools/notifications/`

**Files:**
- `hook.sh` - Claude Code notification hook
- `config.sh` - Configuration (ntfy topic, delay, preferences)
- `send.sh` - Notification sender
- `README.md` - Detailed setup instructions

**Quick Config:**
Edit `dev-tools/notifications/config.sh`:
```bash
NTFY_TOPIC="your-topic-here"        # Subscribe to this on iPhone ntfy app
NOTIFICATION_DELAY=180              # Seconds to wait (default: 3 minutes)
NOTIFY_ON_PERMISSION=true           # Notify on permission blocks
NOTIFY_ON_IDLE=false                # Notify on 60s+ idle (can be noisy)
```

## Installation

### Option 1: Full Symlink (Recommended)

Use this approach to have all toolkit tools available in your project:

```bash
# In your project
ln -s ~/.claude-toolkit/dev-tools .claude/dev-tools
```

Then add to `.claude/settings.local.json`:
```json
{
  "hooks": {
    "Notification": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "/Users/YOUR_USERNAME/.claude-toolkit/dev-tools/notifications/hook.sh"
          }
        ]
      }
    ]
  }
}
```

### Option 2: Selective Tool Symlinks

Link only specific tools you need:

```bash
# In your project
mkdir -p .claude/dev-tools
ln -s ~/.claude-toolkit/dev-tools/notifications .claude/dev-tools/notifications
```

### Gitignore Setup

Add to your project's `.gitignore`:
```
# Claude Code dev tools (symlinked from toolkit)
.claude/dev-tools/
```

## Usage

### Notifications

**One-time setup:**
1. Install ntfy app on iPhone: https://apps.apple.com/app/ntfy/id1625396347
2. Subscribe to your topic in the app (e.g., `claude-code-evantilu-E5B2E127`)
3. Update `dev-tools/notifications/config.sh` with your topic
4. Configure hook in project's `.claude/settings.local.json`
5. Restart Claude Code

**Test notification:**
```bash
~/.claude-toolkit/dev-tools/notifications/send.sh "Test message"
```

**How it works:**
1. Claude Code gets blocked waiting for permission
2. Notification hook triggers automatically
3. Waits configured delay (default: 3 minutes)
4. If still blocked, sends iPhone notification
5. You can respond immediately even when away from computer

## File Structure

```
~/.claude-toolkit/
├── README.md                    # This file
└── dev-tools/
    └── notifications/
        ├── README.md           # Detailed notifications docs
        ├── hook.sh            # Notification hook script
        ├── config.sh          # Configuration
        └── send.sh            # Notification sender
```

## Adding New Tools

To add a new tool to the toolkit:

1. Create tool directory under `dev-tools/`
2. Add documentation (README.md)
3. Implement tool functionality
4. Update this README with tool description
5. Commit and push

Example:
```bash
mkdir -p ~/.claude-toolkit/dev-tools/my-new-tool
# Add your tool files
git add .
git commit -m "feat: add my-new-tool"
```

## Version Control

This toolkit is a git repository. Manage versions like any other project:

```bash
cd ~/.claude-toolkit
git status
git add .
git commit -m "feat: update notification delay"
git push
```

## Sharing

To share this toolkit with team members or use on another machine:

```bash
# Create GitHub repo
cd ~/.claude-toolkit
git init
git add .
git commit -m "feat: initial toolkit setup"
git remote add origin git@github.com:yourusername/claude-toolkit.git
git push -u origin main

# On another machine
git clone git@github.com:yourusername/claude-toolkit.git ~/.claude-toolkit
```

## Compatibility

- **Platform:** macOS, Linux (Windows with WSL)
- **Claude Code:** Compatible with all versions supporting hooks
- **Projects:** Works with any project type

## Troubleshooting

### Symlink not working?
```bash
# Check symlink exists
ls -la .claude/dev-tools

# Should show:
# lrwxr-xr-x ... .claude/dev-tools -> /Users/YOUR_USERNAME/.claude-toolkit/dev-tools
```

### Notifications not sending?
```bash
# Test manually
~/.claude-toolkit/dev-tools/notifications/send.sh "Test"

# Check config
cat ~/.claude-toolkit/dev-tools/notifications/config.sh

# Verify ntfy topic matches your iPhone subscription
```

### Hook not triggering?
1. Verify hook path in `.claude/settings.local.json`
2. Ensure hook script is executable: `chmod +x ~/.claude-toolkit/dev-tools/notifications/*.sh`
3. Restart Claude Code after configuration changes

## License

Personal use. Modify and share as needed.

## Maintenance

**Author:** Evan Ti Lu
**Created:** 2025-10-05
**Last Updated:** 2025-10-05

---

**Happy coding with Claude! 🤖**
