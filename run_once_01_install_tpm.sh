#!/bin/bash

if [ ! -d "$HOME/.config/tmux/plugins/tpm" ]; then
    echo "Installing tmux plugin manager..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.config/tmux/plugins/tpm" && "$HOME/.config/tmux/plugins/tpm/bin/install_plugins"
fi
