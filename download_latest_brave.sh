#!/bin/bash

REPO_OWNER="brave"
REPO_NAME="brave-browser"
ASSET_NAME="Bravearm64Universal.apk"

DOWNLOAD_URL=$(curl -L -s "https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/releases/latest" | \
  jq -r ".assets[] | select(.name | contains(\"${ASSET_NAME}\")).browser_download_url" | grep -v sha256)

if [ -z "$DOWNLOAD_URL" ]; then
    echo "Error: Asset not found or script failed to get the URL."
    exit 1
fi

echo "Downloading asset from: $DOWNLOAD_URL"
curl -L -o "$ASSET_NAME" "$DOWNLOAD_URL"
echo "Download complete."
