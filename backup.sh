#!/bin/bash

# Define the source and backup directories
SOURCE_DIR="$HOME/.config/nvim"

cp -r "$SOURCE_DIR/"* .

echo "Backup of Neovim configuration completed successfully."
