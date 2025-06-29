#!/bin/bash
set -eu

# 色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

# ログ関数（すべて stderr）
print_section() {
    printf "${BOLD}${CYAN}==> %s${RESET}\n" "$1" >&2
}

print_success() {
    printf "${GREEN}✔ %s${RESET}\n" "$1" >&2
}

# Secretlint Git Hooks インストール
if [ ! -d "$HOME/bin/git-hooks" ]; then
    print_section "Installing secretlint git hooks"
    git clone https://github.com/secretlint/git-hooks "$HOME/bin/git-hooks"
    print_success "secretlint git hooks installed"
else
    print_success "secretlint git hooks already installed"
fi
