#!/bin/bash

# Claude Code Notification Sender
# Called by the notification hook when Claude is blocked

# Load configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/config.sh"

# Function to send notification via ntfy.sh
send_ntfy() {
  local message="$1"
  curl -s \
    -H "Title: Claude Code ⏸️" \
    -H "Priority: high" \
    -H "Tags: robot,warning" \
    -d "${message}" \
    "https://ntfy.sh/${NTFY_TOPIC}" > /dev/null 2>&1
}

# Function to send notification via Pushover
send_pushover() {
  local message="$1"
  if [[ -z "$PUSHOVER_USER" || -z "$PUSHOVER_TOKEN" ]]; then
    return 1
  fi
  curl -s \
    -F "token=${PUSHOVER_TOKEN}" \
    -F "user=${PUSHOVER_USER}" \
    -F "title=Claude Code ⏸️" \
    -F "message=${message}" \
    -F "priority=1" \
    "https://api.pushover.net/1/messages.json" > /dev/null 2>&1
}

# Function to send macOS notification
send_macos() {
  local message="$1"
  osascript -e "display notification \"${message}\" with title \"Claude Code\" sound name \"Ping\"" 2>/dev/null
}

# Main notification function
send_notification() {
  local message="$1"

  case $NOTIFICATION_METHOD in
    ntfy)
      send_ntfy "${message}"
      ;;
    pushover)
      send_pushover "${message}"
      ;;
    macos)
      send_macos "${message}"
      ;;
    *)
      echo "Unknown notification method: $NOTIFICATION_METHOD" >&2
      return 1
      ;;
  esac
}

# Parse input and send notification
RAW_MESSAGE="$1"

if [[ "$GENERIC_MESSAGE_ONLY" == "true" ]]; then
  # Most secure: no details
  MESSAGE="Needs approval - check terminal"
elif [[ "$INCLUDE_COMMAND_NAME" == "true" ]]; then
  # Less secure: includes tool name
  MESSAGE="${RAW_MESSAGE}"
else
  # Medium security: generic but informative
  MESSAGE="Permission needed - check terminal"
fi

send_notification "${MESSAGE}"
