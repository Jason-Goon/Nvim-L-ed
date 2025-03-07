#!/bin/sh
set -e

# ensure we're in the home directory
cd "$HOME"

GITHUB_REPO="https://github.com/Jason-Goon/Nvim-L-ed.git"
BRANCH="master"

CONFIG_DIR="$HOME/.config/nvim"
LAZY_DIR="$HOME/.local/share/nvim/lazy"
MATH_TEMPLATE_DIR="$CONFIG_DIR/math-templates"
THEME_PATH="$CONFIG_DIR/lua/themes"

echo "  __    __             __                      __                          __  "
echo " |  \  |  \           |  \                    |  \                        |  \ "
echo " | $$\ | $$ __     __  \$$ ______ ____        | $$          ______    ____| $$ "
echo " | $$$\| $$|  \   /  \|  \|      \    \       | $$ ______  /      \  /      $$ "
echo " | $$$$\ $$ \$$\ /  $$| $$| $$$$$$\$$$$\      | $$|      \|  $$$$$$\|  $$$$$$$ "
echo " | $$\$$ $$  \$$\  $$ | $$| $$ | $$ | $$      | $$ \$$$$$$| $$    $$| $$  | $$ "
echo " | $$ \$$$$   \$$ $$  | $$| $$ | $$ | $$      | $$_____   | $$$$$$$$| $$__| $$ "
echo " | $$  \$$$    \$$$   | $$| $$ | $$ | $$      | $$     \   \$$     \ \$$    $$ "
echo "  \$$   \$$     \$     \$$ \$$  \$$  \$$       \$$$$$$$$    \$$$$$$$  \$$$$$$$ "
echo "                                                                               "

echo "checking for a clean neovim environment..."
if [ -d "$CONFIG_DIR" ]; then
    echo "error: $CONFIG_DIR already exists. please remove the existing configuration first."
    exit 1
fi

echo "proceeding with a clean install..."

# create necessary directories
mkdir -p "$CONFIG_DIR/lua/themes"
mkdir -p "$LAZY_DIR"

# clone neovim configuration into a temporary folder
echo "cloning neovim configuration from github..."
git clone --depth=1 --branch "$BRANCH" "$GITHUB_REPO" "$HOME/Nvim-L-ed"

# copy configuration files into ~/.config/nvim/
echo "copying configuration files into place..."
cp -r "$HOME/Nvim-L-ed/lua/"* "$CONFIG_DIR/lua/"
cp "$HOME/Nvim-L-ed/lua/init.lua" "$CONFIG_DIR/init.lua"
cp -r "$HOME/Nvim-L-ed/math-templates" "$MATH_TEMPLATE_DIR"

# copy ascii art to config
echo "copying ascii art..."
cp "$HOME/Nvim-L-ed/asciiart.txt" "$CONFIG_DIR/asciiart.txt"
echo "✓ ascii art copied successfully."

echo "✓ configuration files copied successfully."

# remove the temporary cloned repo
rm -rf "$HOME/Nvim-L-ed"

# check for system dependencies
echo "checking system dependencies..."
MISSING_PACKAGES=""
for pkg in latexmk zathura node npm unzip ripgrep fd; do
    if ! command -v "$pkg" >/dev/null 2>&1; then
        MISSING_PACKAGES="$MISSING_PACKAGES $pkg"
    fi
done

if [ -n "$MISSING_PACKAGES" ]; then
    echo "⚠ warning: the following dependencies are missing: $MISSING_PACKAGES"
    echo "please install them manually before running neovim."
else
    echo "✓ all necessary dependencies are installed."
fi

# install lazy.nvim if not present
LAZY_PATH="$LAZY_DIR/lazy.nvim"
if [ ! -d "$LAZY_PATH" ]; then
    echo "installing lazy.nvim..."
    git clone --filter=blob:none https://github.com/folke/lazy.nvim.git "$LAZY_PATH"
    echo "✓ lazy.nvim installed."
else
    echo "✓ lazy.nvim already installed, skipping..."
fi

# install neovim plugins
echo "installing neovim plugins..."
nvim --headless "+Lazy sync" +qall
echo "✓ neovim plugins installed successfully."

echo "──────────────────────────────────────────────────────────"
echo "installation complete. launch neovim and start coding!"
echo "──────────────────────────────────────────────────────────"
