#!/bin/sh
set -e

echo "deleting existing neovim configuration..."

# delete neovim config directory if it exists
if [ -d "$HOME/.config/nvim" ]; then
    rm -rf "$HOME/.config/nvim"
    echo "deleted ~/.config/nvim"
else
    echo "no neovim config directory found at ~/.config/nvim"
fi

# delete lazy.nvim installation
if [ -d "$HOME/.local/share/nvim/lazy/lazy.nvim" ]; then
    rm -rf "$HOME/.local/share/nvim/lazy/lazy.nvim"
    echo "deleted lazy.nvim plugin at ~/.local/share/nvim/lazy/lazy.nvim"
else
    echo "no lazy.nvim installation found."
fi

# delete math templates if present
if [ -d "$HOME/.config/nvim/math-templates" ]; then
    rm -rf "$HOME/.config/nvim/math-templates"
    echo "deleted math templates at ~/.config/nvim/math-templates"
else
    echo "no math templates found."
fi

# remove any cached neovim data
if [ -d "$HOME/.local/state/nvim" ]; then
    rm -rf "$HOME/.local/state/nvim"
    echo "deleted neovim cached state at ~/.local/state/nvim"
else
    echo "no cached neovim state found."
fi

# remove cloned repo (if exists)
if [ -d "$HOME/Nvim-L-ed" ]; then
    rm -rf "$HOME/Nvim-L-ed"
    echo "deleted temporary cloned neovim repo at ~/Nvim-L-ed"
fi

echo "Nvim-L-ed has been successfully uninstalled."