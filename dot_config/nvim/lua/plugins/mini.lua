return {
    {
        'nvim-mini/mini.indentscope',
        version = '*',
        config = function()
            require('mini.indentscope').setup({
                draw = {
                    delay = 0,
                    animation = require('mini.indentscope').gen_animation.none(),
                    predicate = function(scope)
                        local ft = vim.api.nvim_get_option_value('filetype', { buf = scope.buf_id })
                        local disabled_ft = {
                            alpha = true,
                            NvimTree = true,
                        }

                        if disabled_ft[ft] then
                            return false
                        end

                        return not scope.body.is_incomplete
                    end,
                },
                options = {
                    n_lines = 300,
                },
                symbol = '┊',
            })
        end,
    },
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
