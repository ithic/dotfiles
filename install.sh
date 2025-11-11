#!/bin/bash
# install.sh

sudo apt-get update
sudo apt-get install -y neovim tmux

# Then symlink your config files
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.config/nvim ~/.config/nvim

# Install Claude Code
curl -fsSL https://releases.claude.ai/claude-code/install.sh | sh
