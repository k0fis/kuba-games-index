#!/bin/bash
# Deploy kuba games index to server
# Usage: ssh kofis.eu 'bash -s' < deploy.sh
#   or run directly on server after git pull

set -e

DEPLOY_DIR="$HOME/www/kuba"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Deploying to $DEPLOY_DIR ..."

# index.html
cp "$SCRIPT_DIR/index.html" "$DEPLOY_DIR/index.html"

# thumbs
mkdir -p "$DEPLOY_DIR/thumbs"
cp "$SCRIPT_DIR/thumbs/"*.jpg "$DEPLOY_DIR/thumbs/"

echo "Done. Files deployed:"
ls -la "$DEPLOY_DIR/index.html"
ls -la "$DEPLOY_DIR/thumbs/"
