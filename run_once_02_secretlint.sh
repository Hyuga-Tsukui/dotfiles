#!/bin/bash

if [ ! -d "$HOME/bin/git-hooks" ]; then
    echo "Installing secretlint git hooks..."
    git clone https://github.com/secretlint/git-hooks "$HOME/bin/git-hooks"
fi