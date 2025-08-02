return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        '<leader>m',
        '<C-e>',
    },
    config = function()
        local harpoon = require('harpoon')
        harpoon:setup({
            global_settings = {
                mark_branch = true, -- Automatically mark the current branch
                exclude_filetypes = { 'harpoon', 'NvimTree' },
                save_on_change = true, -- Save marks when files change
                save_on_toggle = false, -- Save marks when toggling the quick menu
            },
        })

        -- Add a new harpoon mark
        vim.keymap.set('n', '<leader>m', function()
            harpoon:list():add()
        end)
        vim.keymap.set('n', '<C-e>', function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end)
    end,
}
