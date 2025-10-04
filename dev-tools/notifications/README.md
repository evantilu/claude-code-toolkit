# Claude Code Notification System

**⚠️ DEV TOOL ONLY** - Not part of the GST project codebase

This is a personal development tool to receive push notifications when Claude Code gets blocked waiting for permissions.

## Setup (2 minutes)

### 1. Install ntfy App on iPhone
- Download from App Store: https://apps.apple.com/app/ntfy/id1625396347
- Open the app

### 2. Get Your Topic ID
```bash
# Run this to see your unique topic
cd /Users/evantilu/Documents/gst-platform/.claude/dev-tools
source notification-config.sh
echo "Your topic: $NTFY_TOPIC"
```

### 3. Subscribe in ntfy App
- Open ntfy app
- Tap "+" to add subscription
- Enter your topic (from step 2)
- Tap "Subscribe"

### 4. Test It
```bash
# Send a test notification
.claude/dev-tools/send-notification.sh "Test notification"
```

You should see it on your iPhone! 🎉

## Configuration

Edit `notification-config.sh` to customize:

```bash
NOTIFICATION_METHOD="ntfy"        # or "pushover" or "macos"
NOTIFY_ON_PERMISSION=true         # Notify when permission needed
NOTIFY_ON_IDLE=false              # Notify when idle (can be noisy)
GENERIC_MESSAGE_ONLY=true         # Most secure (no details)
```

## Security

**Current settings (most secure):**
- ✅ Generic messages only ("Needs approval")
- ✅ No file paths or commands sent
- ✅ Random unique topic (hard to guess)
- ✅ HTTPS encrypted transmission

**To increase security further:**
Add authentication to your ntfy topic (see ntfy.sh docs).

## Files Structure

```
.claude/
├── hooks/
│   └── notification.sh          # Hook entry point (triggered by Claude)
└── dev-tools/                   # Dev tools (gitignored)
    ├── README.md                # This file
    ├── notification-config.sh   # Configuration
    └── send-notification.sh     # Notification sender
```

## Troubleshooting

**Not receiving notifications?**
1. Check iPhone: Settings → Notifications → ntfy → Allow Notifications
2. Test manually: `.claude/dev-tools/send-notification.sh "test"`
3. Check topic subscription in ntfy app

**Hook not triggering?**
1. Verify config in `.claude/settings.local.json` (hooks section exists)
2. Hook only triggers on permission blocks or 60s idle

## Uninstalling

```bash
# Remove hook configuration from .claude/settings.local.json
# Delete the dev-tools directory
rm -rf .claude/dev-tools
rm .claude/notification-log.txt

# Restore settings.local.json to remove hooks section
```
