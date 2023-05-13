#!/usr/bin/env bash

set -eu

link_to_homedir() {
    command echo "backup old dotfiles..."
    if [ ! -d "$HOME/.dotbackup" ];then
        command echo "$HOME/.dotbackup not found. Auto Make it"
        command mkdir "$HOME/.dotbackup"
    fi

    local script_dir
    script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

    local dotdir
    dotdir=$(dirname "${script_dir}")

    if [[ "$HOME" != "$dotdir" ]];then
        for f in "$dotdir"/.??*; do
            [[ $(basename "$f") == ".DS_Store" ]] && continue
            [[ $(basename "$f") == ".git" ]] && continue

            if [[ -L "$HOME/$(basename "$f")" ]];then
                command echo "$f"
                command rm "$HOME/$(basename "$f")"
            fi

            if [[ -e "$HOME/$(basename "$f")" ]];then
                command echo "$f"
                command mv "$HOME/$(basename "$f")" "$HOME/.dotbackup"
            fi
            command ln -snf "$f" "$HOME"
        done
    else
        command echo "dotfiles is already installed"
    fi
}

link_to_homedir

# https://qiita.com/ko1nksm/items/095bdb8f0eca6d327233#%E7%B5%90%E8%AB%96
ESC=$(printf '\033') # \e や \x1b または $'\e' は使用しない
command echo "${ESC}[1;36m Install completed!!!! ${ESC}[m"