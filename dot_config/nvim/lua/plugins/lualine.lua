return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup({
            -- theme = 'tokyonight',
            sections = {
                lualine_x = { 'overseer' },
            },

            disabled_filetypes = {
                statusline = { 'alpha' },
                winbar = { 'alpha' },
            },
        })
    end,
    event = 'VeryLazy',
}
