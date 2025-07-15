return {
    -- dir = "~/ws/plamo-translate-nvim",
    'Hyuga-Tsukui/plamo-translate-nvim',
    keys = {
        {
            '<leader>ts',
            '<cmd>PlamoTranslateSelection<cr>',
            desc = 'Translate Selection',
            mode = { 'v', 'n' },
        },
        {
            '<leader>tr',
            '<cmd>PlamoTranslateReplace<cr>',
            desc = 'Translate Selection With Replace',
            mode = { 'v', 'n' },
        },
    },
    opts = {
        progress_position = 'top',
    },
}
