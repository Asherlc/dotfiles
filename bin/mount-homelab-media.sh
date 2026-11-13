#!/bin/bash
# Mount the Synology NAS data share via SMB, fetching the password from 1Password.
# Used by the com.homelab.smb-mount launchd agent.
set -euo pipefail

MOUNT_POINT="$HOME/mnt/homelab-media"
NAS_HOST="192.168.1.161"
NAS_SHARE="data"
NAS_USER="asherlc"

# Already mounted and healthy? exit.
if mount | grep -q " $MOUNT_POINT "; then
    if ls "$MOUNT_POINT/media" >/dev/null 2>&1; then
        echo "$(date -Iseconds) already mounted and healthy"
        exit 0
    fi
    echo "$(date -Iseconds) mount is stale, unmounting"
    diskutil unmount force "$MOUNT_POINT" || true
fi

mkdir -p "$MOUNT_POINT"

# Fetch password from 1Password
PASS=$(/opt/homebrew/bin/op item get "Synology NAS" --fields password 2>/dev/null)
if [ -z "$PASS" ]; then
    echo "$(date -Iseconds) failed to fetch password from 1Password" >&2
    exit 1
fi

# URL-encode password for SMB URI
ENC_PASS=$(/usr/bin/python3 -c "import urllib.parse,sys; print(urllib.parse.quote(sys.argv[1], safe=''))" "$PASS")

/sbin/mount_smbfs "//${NAS_USER}:${ENC_PASS}@${NAS_HOST}/${NAS_SHARE}" "$MOUNT_POINT"
echo "$(date -Iseconds) mounted ${NAS_HOST}:${NAS_SHARE} at ${MOUNT_POINT}"
