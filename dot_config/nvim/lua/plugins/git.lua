return {
    'tpope/vim-fugitive',
    event = 'VeryLazy',
    config = function()
        vim.keymap.set('n', '<leader>gs', ':tab Git<CR>', { desc = 'Git Status' })
        vim.keymap.set('n', '<leader>gc', ':Git commit<CR>', { desc = 'Git Commit' })
        -- vim.keymap.set('n', '<leader>gp', ':Git push<CR>', { desc = 'Git Push' })
        -- vim.keymap.set('n', '<leader>gl', ':Git pull<CR>', { desc = 'Git Pull' })
        vim.keymap.set('n', '<leader>gb', ':Git blame<CR>', { desc = 'Git Blame' })
        vim.keymap.set('n', '<leader>gd', ':Gdiffsplit<CR>', { desc = 'Git Diff Split' })
    end,
}
