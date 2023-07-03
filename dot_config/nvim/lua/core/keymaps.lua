vim.g.mapleader = " "

local keymap = vim.keymap

-- general keymaps

keymap.set('i', 'jj', '<ESC>')

keymap.set('n', '<leader>nh', ':nohl<CR>')

keymap.set('n', 'x', '"_x"')
