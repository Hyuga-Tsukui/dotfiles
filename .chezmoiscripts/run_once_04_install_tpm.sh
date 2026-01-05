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

# TODO: 依存を無くしたい. run_x間でプロセスが共有されないため、nix-daemonの環境を再度読み込む必要がある.
if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

# TPM (tmux plugin manager)
if [ ! -d "$HOME/.config/tmux/plugins/tpm" ]; then
    print_section "Installing tmux plugin manager"

    git clone --depth 1 https://github.com/tmux-plugins/tpm "$HOME/.config/tmux/plugins/tpm"

    # tmux環境外で実行するため、TMUX_PLUGIN_MANAGER_PATHを指定してプラグインをインストール
    export TMUX_PLUGIN_MANAGER_PATH="$HOME/.config/tmux/plugins/"
    "$HOME/.config/tmux/plugins/tpm/bin/install_plugins"

    print_success "tmux plugin manager installed"
else
    print_success "tmux plugin manager already installed"
fi
