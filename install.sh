#!/bin/bash

NVIM_CONFIG_DIR="$HOME/.config/nvim"
NVIM_BACKUP_DIR="$HOME/.config/nvim.bak"

if [ -d "$NVIM_CONFIG_DIR" ]; then
  if [ -e "$NVIM_BACKUP_DIR" ]; then
    TIMESTAMP="$(date +%Y%m%d%H%M%S)"
    OLD_BACKUP_DIR="${NVIM_BACKUP_DIR}.${TIMESTAMP}"
    echo "Existing backup found. Moving it to $OLD_BACKUP_DIR..."
    mv "$NVIM_BACKUP_DIR" "$OLD_BACKUP_DIR"
  fi

  echo "Backing up current Neovim configuration to $NVIM_BACKUP_DIR..."
  mv "$NVIM_CONFIG_DIR" "$NVIM_BACKUP_DIR"
else
  echo "No existing Neovim configuration found to back up."
fi

echo "Copying project files to $NVIM_CONFIG_DIR..."
mkdir -p "$NVIM_CONFIG_DIR"
rsync -av --exclude='.git' --exclude='backup.sh' --exclude='install.sh' ./ "$NVIM_CONFIG_DIR"

echo "Installation completed successfully."
