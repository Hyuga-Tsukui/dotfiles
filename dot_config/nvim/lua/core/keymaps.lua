vim.g.mapleader = " "

local keymap = vim.keymap

-- general keymaps
keymap.set('i', 'jj', '<ESC>')
keymap.set('n', '<leader>nh', ':nohl<CR>')
keymap.set('n', '<C-b>', '<cmd>Fern . -drawer -reveal=%<CR>')

-- window keymaps
keymap.set('n', 'ss', ':split<Return><C-w>w')
keymap.set('n', 'sv', ':vsplit<Return><C-w>w')
keymap.set('n', 'sh', '<C-w>h')
keymap.set('n', 'sk', '<C-w>k')
keymap.set('n', 'sj', '<C-w>j')
keymap.set('n', 'sl', '<C-w>l')

vim.api.nvim_set_keymap('n', 'x', '"_x', { noremap = true, silent = true })
