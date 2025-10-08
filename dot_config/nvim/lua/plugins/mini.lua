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
        keys = {
            -- Buffer
            '[b',
            ']b',
            '[B',
            ']B',
            -- Conflict Marker
            '[x',
            ']x',
            '[X',
            ']X',
            -- Indent Change
            '[I',
            'I]',
            '[i',
            'i]',
        },
    },
}
