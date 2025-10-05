#!/bin/bash

# Claude Code Notification System Configuration
# This file contains configuration for push notifications when Claude gets blocked

# Choose your notification method: "ntfy", "pushover", or "macos"
NOTIFICATION_METHOD="ntfy"

# ntfy.sh configuration (free, no signup)
# Generate a unique topic: https://ntfy.sh/
# Install ntfy app on iPhone: https://apps.apple.com/app/ntfy/id1625396347
# Subscribe to your topic in the app
NTFY_TOPIC="claude-code-evantilu-E5B2E127"  # Fixed topic - subscribed on iPhone

# Pushover configuration (requires account: https://pushover.net/)
PUSHOVER_USER=""      # Your Pushover user key
PUSHOVER_TOKEN=""     # Your Pushover app token

# Notification preferences
NOTIFY_ON_PERMISSION=true    # Notify when permission needed
NOTIFY_ON_IDLE=false         # Notify when idle for 60+ seconds (can be noisy)
NOTIFICATION_DELAY=120       # Seconds to wait before sending notification (2 minutes - avoid spam when active)

# Security: What information to include in notifications
INCLUDE_COMMAND_NAME=false   # Set to true to include command names (less secure)
GENERIC_MESSAGE_ONLY=true    # Only send "Claude needs approval" (most secure)
