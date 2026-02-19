#!/usr/bin/env bash
set -e

# Setup clang-mirror (Linux)

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$( cd "$SCRIPT_DIR/.." && pwd )"

INSTALL_DIR="$PROJECT_ROOT/clang-mirror"
RELEASE_TAG="release-latest"
REPO="ReflectCxx/clang-mirror"

ASSET="clang-mirror-linux.tar.gz"
DOWNLOAD_URL="https://github.com/${REPO}/releases/download/${RELEASE_TAG}/${ASSET}"

# Ensure curl and certificates exist
if ! command -v curl >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y curl ca-certificates
fi

if [ -f "$INSTALL_DIR/clang-mirror" ]; then
    echo "clang-mirror already installed at:"
    echo "$INSTALL_DIR"
    echo
    echo "Skipping download."
    exit 0
fi

mkdir -p "$INSTALL_DIR"

echo
echo "Downloading clang-mirror from:"
echo "$DOWNLOAD_URL"
echo

curl -L -o "$INSTALL_DIR/$ASSET" "$DOWNLOAD_URL"

echo
echo "Extracting..."

tar -xzf "$INSTALL_DIR/$ASSET" -C "$INSTALL_DIR"

rm "$INSTALL_DIR/$ASSET"

chmod +x "$INSTALL_DIR/clang-mirror"

echo
echo "clang-mirror successfully installed at:"
echo "$INSTALL_DIR"
echo
