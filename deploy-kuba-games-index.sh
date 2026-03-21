#!/bin/bash
# Deploy latest kuba-games-index release from GitHub
# Updates only index.html and thumbs/ — does NOT touch game dirs (gm00x)
# Usage: ./deploy-kuba-games-index.sh [target_dir]
# Default target: ~/www/kuba

set -e

REPO="k0fis/kuba-games-index"
TARGET="${1:-$HOME/www/kuba}"
TMP=$(mktemp -d)

echo "Fetching latest release from github.com/$REPO ..."
URL=$(curl -s "https://api.github.com/repos/$REPO/releases/latest" \
  | grep -o '"browser_download_url": *"[^"]*"' \
  | head -1 \
  | cut -d'"' -f4)

if [ -z "$URL" ]; then
  echo "ERROR: No release found."
  rm -rf "$TMP"
  exit 1
fi

echo "Downloading: $URL"
curl -sL "$URL" -o "$TMP/kuba-games-index.tar.gz"

echo "Extracting to: $TARGET"
mkdir -p "$TARGET/thumbs"
tar -xzf "$TMP/kuba-games-index.tar.gz" -C "$TARGET"

rm -rf "$TMP"
echo "Done. Updated index.html + thumbs/ in $TARGET"
