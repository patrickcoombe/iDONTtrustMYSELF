#!/bin/bash
# A script to block websites by adding entries to /etc/hosts.
# Usage: sudo ./block_sites.sh twitter.com reddit.com etc
# This script is confirmed to work on pop os only I am sure it works on other distros

HOSTS_FILE="/etc/hosts"
REDIRECT_IP="127.0.0.1"

# --- Safety Checks ---
# 1. Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo."
  echo "Usage: sudo $0 domain1.com domain2.com ..."
  exit 1
fi

# 2. Check if chattr (the locking command) is available
if ! command -v chattr &> /dev/null; then
    echo "Warning: 'chattr' command not found. The lock/unlock scripts won't work."
    echo "This utility should be included in popos by default, so this is unusual."
fi

# 3. Check if any domains were provided
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 domain1.com domain2.com ..."
    echo "Example: $0 twitter.com www.twitter.com reddit.com www.reddit.com"
    exit 1
fi

# --- Main Logic ---
echo "Updating $HOSTS_FILE..."
echo ""

for domain in "$@"; do
    # Check if the domain is already in the hosts file
    if grep -q -E "^\s*$REDIRECT_IP\s+$domain" "$HOSTS_FILE"; then
        echo "  - $domain (is already blocked)"
    else
        # Add the domain
        # We add a newline just in case the file doesn't end with one
        echo "" >> "$HOSTS_FILE"
        echo "$REDIRECT_IP $domain # Blocked for productivity" >> "$HOSTS_FILE"
        echo "  - $domain (has been added to the blocklist)"
    fi
done

echo ""
echo "Block list updated successfully."
echo "Run './lock_hosts.sh' to prevent easy changes."
