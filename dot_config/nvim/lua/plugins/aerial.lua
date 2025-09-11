return {
    'stevearc/aerial.nvim',
    opts = {
        on_attach = function(bufnr)
            -- Jump forwards/backwards with '{' and '}'
            vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
            vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
        end,
        layout = {
            max_width = { 40, 0.3 },
            min_width = 20,
            default_direction = 'prefer_left',
            placement = 'window',
        },
        backends = { 'treesitter', 'lsp', 'markdown', 'man' },
        filter_kind = {
            'Class',
            'Constructor',
            'Enum',
            'Function',
            'Interface',
            'Module',
            'Method',
            'Struct',
        },
    },
    -- Optional dependencies
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
    },
    keys = {
        {
            '<leader>uA',
            function()
                require('aerial').toggle()
            end,
            desc = 'Toggle Outline (Aerial)',
        },
        {
            '<leader>ss',
            function()
                require('aerial').snacks_picker({
                    layout = {
                        preset = 'dropdown',
                        preview = false,
                    },
                })
            end,
            desc = 'Symbols Picker (Aerial)',
        },
    },
}
