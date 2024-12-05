#!/bin/bash

# Check for sudo privileges
if [[ $EUID -ne 0 ]]; then
    echo "This script requires sudo privileges. Please run as root or use sudo."
    exit 1
fi

# Define installation paths
INSTALL_DIR="/usr/local/share/cleankit"
BIN_PATH="/usr/local/bin/cleankit"
REPO_URL="https://raw.githubusercontent.com/antaripdebgupta/cleankit/main"

echo "Installing cleankit..."

# Create the directory for cleankit
sudo mkdir -p "$INSTALL_DIR"

# Download the scripts from the repository
sudo curl -s "$REPO_URL/cleankit.sh" -o "$INSTALL_DIR/cleankit.sh"
sudo curl -s "$REPO_URL/reactjsClean.sh" -o "$INSTALL_DIR/reactjsClean.sh"
sudo curl -s "$REPO_URL/nextjsClean.sh" -o "$INSTALL_DIR/nextjsClean.sh"
sudo curl -s "$REPO_URL/remixClean.sh" -o "$INSTALL_DIR/remixClean.sh"

# Make the main script executable
sudo chmod +x "$INSTALL_DIR/cleankit.sh"

# Create a symlink for cleankit in /usr/local/bin
sudo ln -sf "$INSTALL_DIR/cleankit.sh" "$BIN_PATH"

echo "Cleankit installed successfully! You can now use the 'cleankit' command globally."
