return {
    'nvim-tree/nvim-tree.lua',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        require('nvim-tree').setup({
            sort = {
                sorter = 'case_sensitive',
            },
            filters = {
                dotfiles = false,
            },
            renderer = {
                indent_markers = {
                    enable = true,
                },
            },
            actions = {
                open_file = {
                    resize_window = true,
                },
            },
        })
        -- vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle File Explorer' })
    end,
    keys = {
        { '<leader>e', ':NvimTreeToggle<CR>', desc = 'Toggle File Explorer' },
    },
}
