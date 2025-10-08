return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    ft = { 'markdown' },
    keys = {
        { '<leader>rm', ':RenderMarkdown toggle<CR>', desc = 'Render Markdown Toggle' },
    },
    opts = {},
    config = function(_, opts)
        require('render-markdown').setup({
            code = {
                width = 'block',
                border = 'thick',
            },
            heading = {
                width = 'block',
                left_pad = 0,
                right_pad = 4,
                icons = {},
            },
        })
    end,
}
