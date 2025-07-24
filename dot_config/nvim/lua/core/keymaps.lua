vim.g.mapleader = ' '

vim.keymap.set('n', '<leader>nh', ':nohl<CR>', { noremap = true, silent = true })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', '<leader>dq', ':lua vim.diagnostic.setloclist()<CR>')

vim.keymap.set(
    'n',
    '?',
    '<cmd>silent vimgrep//gj%|copen<cr>',
    { desc = 'Populate latest search result to quickfix list' }
)

vim.keymap.set('n', '<leader>vs', '<cmd>vsplit<cr><c-w>w', { desc = 'Split window vertically and switch to it' })

vim.schedule(function()
    vim.keymap.set('n', ';', ':', { noremap = true })
    vim.keymap.set('n', ':', ';', { noremap = true })
end)
