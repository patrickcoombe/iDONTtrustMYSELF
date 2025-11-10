#!/bin/bash
# Unlocks the /etc/hosts file by removing the 'immutable' attribute.
# This script USES 'chattr' (standard on Pop!_OS).

HOSTS_FILE="/etc/hosts"

# 1. Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo."
  exit 1
fi

# 2. Check if chattr command exists
if ! command -v chattr &> /dev/null; then
    echo "Error: 'chattr' command not found."
    echo "This utility should be included in Pop!_OS by default."
    exit 1
fi

echo "Removing the 'immutable' attribute from $HOSTS_FILE..."
chattr -i "$HOSTS_FILE"

echo ""
echo "$HOSTS_FILE is now unlocked."
echo "You can now edit it or run the 'block_sites.sh' script again."
