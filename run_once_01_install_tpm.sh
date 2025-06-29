#!/bin/bash
set -eu

# 色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

# ログ関数（すべて stderr に出力）
print_section() {
    printf "${BOLD}${CYAN}==> %s${RESET}\n" "$1" >&2
}

print_info() {
    printf "${YELLOW}- %s${RESET}\n" "$1" >&2
}

print_success() {
    printf "${GREEN}✔ %s${RESET}\n" "$1" >&2
}

print_error() {
    printf "${RED}✖ %s${RESET}\n" "$1" >&2
}

# TPM (tmux plugin manager)
if [ ! -d "$HOME/.config/tmux/plugins/tpm" ]; then
    print_section "Installing tmux plugin manager"
    git clone https://github.com/tmux-plugins/tpm "$HOME/.config/tmux/plugins/tpm" \
        && "$HOME/.config/tmux/plugins/tpm/bin/install_plugins"
    print_success "tmux plugin manager installed"
else
    print_success "tmux plugin manager already installed"
fi

# Catppuccin theme
if [ ! -d "$HOME/.config/tmux/plugins/catppuccin" ]; then
    print_section "Installing tmux catppuccin"
    mkdir -p "$HOME/.config/tmux/plugins/catppuccin"
    git clone -b v2.1.2 https://github.com/catppuccin/tmux.git "$HOME/.config/tmux/plugins/catppuccin/tmux"
    print_success "catppuccin theme cloned"

    print_section "Installing cyberdream theme"
    CYBERDREAM=$(curl -fsSL https://raw.githubusercontent.com/scottmckendry/cyberdream.nvim/refs/heads/main/extras/tmux/cyberdream.conf)
    echo "$CYBERDREAM" > "$HOME/.config/tmux/plugins/catppuccin/tmux/themes/catppuccin_cyberdream.tmuxtheme"
    print_success "cyberdream theme installed"
else
    print_success "tmux catppuccin already installed"
fi
