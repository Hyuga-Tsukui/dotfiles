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
                find = 'gsf', -- Find surrounding (to the right)
                find_left = 'gsF', -- Find surrounding (to the left)
                highlight = 'gsh', -- Highlight surrounding
                update_n_lines = 'gsn', -- Update `n_lines`
                suffix_last = 'l', -- Suffix to search with "prev" method
                suffix_next = 'n', -- Suffix to search with "next" method
            },
        },
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
}
