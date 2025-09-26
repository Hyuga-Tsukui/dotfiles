vim.g.mapleader = ' '

-- 検索ハイライトを消す
vim.keymap.set('n', '<leader>nh', ':nohl<CR>', { noremap = true, silent = true })

-- visualモードで選択範囲を動かす
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- diagnosticをquickfixにセット
vim.keymap.set('n', 'qd', ':lua vim.diagnostic.setloclist()<CR>')

-- 最後の検索結果をquickfixにセット
vim.keymap.set(
    'n',
    'q/',
    '<cmd>silent vimgrep//gj%|copen<cr>',
    { desc = 'Populate latest search result to quickfix list' }
)
