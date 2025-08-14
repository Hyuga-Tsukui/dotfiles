return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup({
            theme = 'tokyonight',
            sections = {
                lualine_x = { 'overseer' },
            },
        })
    end,
    event = 'VeryLazy',
}
