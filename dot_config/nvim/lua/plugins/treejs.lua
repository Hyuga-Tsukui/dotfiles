return {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
    config = function()
        require('treesj').setup({})
    end,
    keys = {
        { '<leader>j', '<cmd>TSJToggle<cr>', desc = 'Toggle Treesj' },
        { '<leader>J', '<cmd>TSJSplit<cr>', desc = 'Split Treesj' },
        { '<leader>K', '<cmd>TSJJoin<cr>', desc = 'Join Treesj' },
    },
}
