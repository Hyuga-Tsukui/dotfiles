return {
    {
        'nvim-mini/mini.surround',
        version = '*',
        keys = { 'ys', 'ds', 'cs' },
        opts = {
            mappings = {
                add = 'ys', -- Add surrounding in Normal and Visual modes
                delete = 'ds', -- Delete surrounding
                replace = 'cs', -- Change surrounding
            },
        },
        config = function(_, opts)
            require('mini.surround').setup(opts)
        end,
    },
    {
        'nvim-mini/mini.pairs',
        version = '*',
        event = 'InsertEnter',
        config = function()
            require('mini.pairs').setup({})
        end,
    },
    {
        'nvim-mini/mini.splitjoin',
        version = '*',
        keys = { 'gS' },
        config = function()
            require('mini.splitjoin').setup({})
        end,
    },
    {
        'nvim-mini/mini.bracketed',
        version = '*',
        config = function()
            require('mini.bracketed').setup({})
        end,
        event = 'VeryLazy',
    },
}
