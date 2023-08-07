vim.g.mapleader = " "

local keymap = vim.keymap

-- general keymaps

keymap.set('i', 'jj', '<ESC>')

keymap.set('n', '<leader>nh', ':nohl<CR>')

keymap.set('n', '<C-b>', '<cmd>Fern . -drawer -reveal=%<CR>')

vim.api.nvim_set_keymap('n', 'x', '"_x', { noremap = true, silent = true })
