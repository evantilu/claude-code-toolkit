#!/bin/bash

# Claude Code Notification Hook
# Triggers when: 1) Permission needed, 2) Idle for 60+ seconds
# Only notifies after NOTIFICATION_DELAY seconds to avoid spam when user is active
# This is a DEV TOOL - not part of the GST project codebase

# Get script directory (notifications folder)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Debug log
DEBUG_LOG="${SCRIPT_DIR}/../hook-debug.log"
echo "[$(date)] Hook triggered" >> "$DEBUG_LOG"

# Read hook input from stdin
INPUT=$(cat)
echo "Input: $INPUT" >> "$DEBUG_LOG"

# Extract the message
MESSAGE=$(echo "$INPUT" | grep -o '"message":"[^"]*"' | cut -d'"' -f4)

# Load configuration to check preferences
source "${SCRIPT_DIR}/config.sh"

# Determine if we should notify
SHOULD_NOTIFY=false

if [[ "$MESSAGE" == *"permission"* && "$NOTIFY_ON_PERMISSION" == "true" ]]; then
  SHOULD_NOTIFY=true
elif [[ "$MESSAGE" == *"waiting"* && "$NOTIFY_ON_IDLE" == "true" ]]; then
  SHOULD_NOTIFY=true
fi

# Send notification if configured (with delay to avoid spam)
if [[ "$SHOULD_NOTIFY" == "true" ]]; then
  echo "Waiting ${NOTIFICATION_DELAY}s before sending notification..." >> "$DEBUG_LOG"
  # Run in background: wait for delay, then send notification
  (
    sleep "${NOTIFICATION_DELAY}"
    # Only send if hook wasn't cancelled (basic check - user might have responded)
    echo "[$(date)] Delay complete, sending notification: $MESSAGE" >> "$DEBUG_LOG"
    "${SCRIPT_DIR}/send.sh" "${MESSAGE}"
  ) &
else
  echo "Not notifying (SHOULD_NOTIFY=$SHOULD_NOTIFY)" >> "$DEBUG_LOG"
fi

# Always exit 0 to not interfere with Claude's operation
exit 0
