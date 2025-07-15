return {
    'williamboman/mason-null-ls.nvim',

    event = { 'BufRead', 'BufNewFile' },
    dependencies = {
        'williamboman/mason.nvim',
        {
            'nvimtools/none-ls.nvim',
            dependencies = {
                'nvim-lua/plenary.nvim',
            },
        },
    },

    config = function()
        local lsp_utils = require('utils.lsp')
        require('mason').setup({
            ensure_installed = lsp_utils.get_available_lsp_servers(),
            automatic_installation = true,
        })
        require('mason-null-ls').setup({
            automatic_installation = false,
            handlers = {},
        })
        local null_ls = require('null-ls')
        null_ls.setup({})
    end,
}
