return {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {
        library = {
            'lazy.nvim',
            { path = '${3rd}/luv/library', words = { 'vim%.uv', 'vim.loop' } },

            { path = 'snacks.nvim/lua/snacks' },
            { path = 'blink.nvim/lua/blink' },
            { path = 'overseer.nvim/lua/overseer' },
        },
    },
}
