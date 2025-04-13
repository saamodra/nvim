#!/bin/bash

NVIM_CONFIG_DIR="$HOME/.config/nvim"
NVIM_BACKUP_DIR="$HOME/.config/nvim.bak"

if [ -d "$NVIM_CONFIG_DIR" ]; then
  echo "Backing up current Neovim configuration to $NVIM_BACKUP_DIR..."
  cp -r "$NVIM_CONFIG_DIR" "$NVIM_BACKUP_DIR"
else
  echo "No existing Neovim configuration found to back up."
fi

echo "Copying project files to $NVIM_CONFIG_DIR..."
mkdir -p "$NVIM_CONFIG_DIR"
cp -r . "$NVIM_CONFIG_DIR"

echo "Installation completed successfully."
