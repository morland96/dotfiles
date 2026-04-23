# Dotfiles

Personal macOS development environment configuration files.

## What's Included

### Window Management
- **AeroSpace** (`.aerospace.toml`) - Tiling window manager with vim-style navigation (`alt+hjkl`), workspace assignments, and SketchyBar integration

### Terminal
- **Ghostty** (`ghostty/`) - Primary terminal emulator (Catppuccin Macchiato theme, Maple Mono NF font, quick terminal via `alt+backtick`)
- **WezTerm** (`wezterm/`) - Alternative terminal configuration
- **Kitty** (`kitty/`) - Alternative terminal with custom kitten scripts

### Terminal Multiplexer
- **tmux** (`.tmux.conf`) - Prefix `C-g`, vim copy-mode, Catppuccin Mocha theme, smart-splits integration with Neovim, popup shells and git log viewer
- **Zellij** (`zellij/`) - Alternative multiplexer configuration

### Editor
- **Neovim** (`nvim/`) - LazyVim-based config with Catppuccin Mocha colorscheme. Includes AI (CodeCompanion/Copilot), git, Java, Python, Lua, and markdown plugins
- **IdeaVim** (`.ideavimrc`) - JetBrains vim emulation with Intellimacs, easymotion, surround, multiple-cursors, and Spacemacs-style keybindings (leader: `,`)

### Shell
- **Zsh** (`zsh/`) - Custom completions plugin

### File Manager
- **Yazi** (`yazi/`) - Terminal file manager with Catppuccin theme, git integration, and HEIC image preview

### Status Bar
- **SketchyBar** (`sketchybar/`) - Lua-based macOS menu bar replacement with workspace indicators, widgets (battery, volume, wifi, calendar), and media controls

### Tools
- **mise** (`mise.toml`) - Runtime version manager (Node.js)
- **skhd** (`.skhdrc`) - Hotkey daemon config

### Scripts
- `scripts/tmx` - Tmux session launcher with shared window support (creates linked sessions to share windows across terminals)
- `scripts/better-git-branch.sh` - Enhanced git branch listing with ahead/behind counts

## Setup

These configs are meant to be symlinked to their expected locations (e.g., `~/.config/nvim`, `~/.tmux.conf`, `~/.config/ghostty`). The exact symlink strategy is left to the user.

## Key Bindings

| Context    | Binding            | Action              |
|------------|--------------------|---------------------|
| AeroSpace  | `alt+hjkl`         | Focus window        |
| AeroSpace  | `alt+shift+hjkl`   | Move window         |
| AeroSpace  | `alt+1-8`          | Switch workspace    |
| AeroSpace  | `alt+f`            | Fullscreen          |
| Ghostty    | `alt+backtick`     | Toggle quick terminal |
| tmux       | `C-g` (prefix)     | Prefix key          |
| tmux       | `C-hjkl`           | Navigate panes (smart-splits) |
| tmux       | `prefix+Space`     | Quick action menu   |
| tmux       | `prefix+t`         | Popup shell         |
| tmux       | `prefix+g`         | Popup git log       |
| IdeaVim    | `,` (leader)       | Leader key          |
