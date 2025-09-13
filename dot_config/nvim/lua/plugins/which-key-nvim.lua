return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
        plugins = {
            presets = {
                operators = false,
                motions = false,
                text_objects = true,
                z = false,
                g = false,
            },
        },
    },
    keys = {
        {
            '<leader>?',
            function()
                require('which-key').show({ global = false })
            end,
            desc = 'Buffer Local Keymaps (which-key)',
        },
    },
}
