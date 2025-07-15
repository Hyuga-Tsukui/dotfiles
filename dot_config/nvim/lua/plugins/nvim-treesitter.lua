return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'CursorMoved', 'BufReadPre', 'BufNewFile' },
    exclude = { 'NvimTree' },
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
        local configs = require('nvim-treesitter.configs')

        configs.setup({
            ensure_installed = {
                'vimdoc',
                'javascript',
                'typescript',
                'lua',
                'go',
            },

            sync_install = false,
            ignore_install = {
                'markdown',
            },
            auto_install = true,

            modules = {},
            highlight = {
                enable = true,
                disable = { 'markdown' }, -- disable markdown highlighting
                additional_vim_regex_highlighting = false,
            },
        })
        -- -- REF: https://github.com/nvim-treesitter/nvim-treesitter/issues/2825#issuecomment-1547409415
        -- vim.api.nvim_create_autocmd({
        --     "BufEnter",
        --     "BufWinEnter",
        -- }, {
        --     pattern = { "*.json" },
        --     callback = function()
        --         vim.cmd("set conceallevel=0")
        --     end,
        -- })
        -- vim.api.nvim_create_autocmd({
        --     "BufLeave",
        --     "BufWinLeave",
        -- }, {
        --     pattern = { "*.md" },
        --     callback = function()
        --         vim.cmd("set conceallevel=3")
        --     end,
        -- })
    end,
}
