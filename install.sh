#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

link() {
    local src="$1" dst="$2"
    if [ -e "$dst" ] || [ -L "$dst" ]; then
        echo "  Skipping $dst (already exists)"
        return
    fi
    mkdir -p "$(dirname "$dst")"
    ln -s "$src" "$dst"
    echo "  $dst -> $src"
}

echo "Installing dotfiles from $DOTFILES"
echo

# Neovim
echo "Neovim"
link "$DOTFILES/nvim" "$HOME/.config/nvim"

# Ghostty
echo "Ghostty"
link "$DOTFILES/ghostty" "$HOME/.config/ghostty"

# WezTerm
echo "WezTerm"
link "$DOTFILES/wezterm/wezterm.lua" "$HOME/.wezterm.lua"

# Kitty
echo "Kitty"
link "$DOTFILES/kitty" "$HOME/.config/kitty"

# tmux
echo "tmux"
link "$DOTFILES/.tmux.conf" "$HOME/.tmux.conf"

# Zellij
echo "Zellij"
link "$DOTFILES/zellij" "$HOME/.config/zellij"

# AeroSpace
echo "AeroSpace"
link "$DOTFILES/.aerospace.toml" "$HOME/.aerospace.toml"

# SketchyBar
echo "SketchyBar"
link "$DOTFILES/sketchybar" "$HOME/.config/sketchybar"

# Yazi
echo "Yazi"
link "$DOTFILES/yazi" "$HOME/.config/yazi"

# IdeaVim
echo "IdeaVim"
link "$DOTFILES/.ideavimrc" "$HOME/.ideavimrc"

# skhd
echo "skhd"
link "$DOTFILES/.skhdrc" "$HOME/.skhdrc"

# mise
echo "mise"
link "$DOTFILES/mise.toml" "$HOME/.config/mise/config.toml"

# Zsh completions
echo "Zsh"
link "$DOTFILES/zsh/zshcomp" "$HOME/.config/zsh/zshcomp"

# Scripts
echo "Scripts"
mkdir -p "$HOME/.local/bin"
for script in "$DOTFILES/scripts/"*; do
    link "$script" "$HOME/.local/bin/$(basename "$script")"
done

echo
echo "Done! Make sure ~/.local/bin is in your PATH."
