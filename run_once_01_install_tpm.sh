#!/bin/bash

if [ ! -d "$HOME/.config/tmux/plugins/tpm" ]; then
    echo "Installing tmux plugin manager..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.config/tmux/plugins/tpm" && "$HOME/.config/tmux/plugins/tpm/bin/install_plugins"
fi

if [ ! -d "$HOME/.config/tmux/plugins/catppuccin" ]; then
    echo "Installing tmux catppuccin..."
    mkdir -p ~/.config/tmux/plugins/catppuccin
    git clone -b v2.1.2 https://github.com/catppuccin/tmux.git $HOME/.config/tmux/plugins/catppuccin/tmux
    
    echo "Installing cyberdream theme..."
    CYBERDREAM=$(curl https://raw.githubusercontent.com/scottmckendry/cyberdream.nvim/refs/heads/main/extras/tmux/cyberdream.tmuxtheme)
    echo "$CYBERDREAM" > $HOME/.config/tmux/plugins/catppuccin/tmux/themes/catppuccin_cyberdream.tmuxtheme
fi
