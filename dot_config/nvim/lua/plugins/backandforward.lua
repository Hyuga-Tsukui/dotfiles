return {
    'https://github.com/Bakudankun/BackAndForward.vim',
    event = 'VeryLazy',
    config = function()
        vim.keymap.set('n', 'g<C-o>', '<Plug>(backandforward-back)', { desc = 'Go Back' })
        vim.keymap.set('n', 'g<C-i>', '<Plug>(backandforward-forward)', { desc = 'Go Forward' })
    end,
}
