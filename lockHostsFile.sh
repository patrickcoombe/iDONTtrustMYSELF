#!/bin/bash
# Locks the /etc/hosts file to prevent accidental or impulsive edits.
# This script USES 'chattr', which is standard on popos

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

echo "Setting the 'immutable' file attribute on $HOSTS_FILE..."
chattr +i "$HOSTS_FILE"

echo ""
echo "$HOSTS_FILE is now locked."
echo "Not even root can edit or delete it without first unlocking."
echo "To unlock, run: sudo ./unlock_hosts.sh"
