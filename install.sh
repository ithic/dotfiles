#!/bin/bash
# install.sh

sudo apt-get update
sudo apt-get install -y neovim tmux

DOTFILES_DIR="/workspaces/.codespaces/.persistedshare/dotfiles"

# Create the ~/.config directory if it doesn't exist
mkdir -p "$HOME/.config"

# Symlink specific config files/folders
ln -sfn "$DOTFILES_DIR/.config/tmux" "$HOME/.config/tmux"
ln -sfn "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim" 

# Other dotfiles (e.g., .bashrc)
ln -sfn "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

# Install Claude Code
curl -fsSL https://releases.claude.ai/claude-code/install.sh | sh
