return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        { '<leader>a', desc = 'Add Harpoon Mark' },
        { '<leader>m', desc = 'Toggle Harpoon Menu' },
        { '<leader>h', desc = 'Open harpoon 1' },
        { '<leader>j', desc = 'Open harpoon 2' },
        { '<leader>k', desc = 'Open harpoon 3' },
        { '<leader>l', desc = 'Open harpoon 4' },
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
        vim.keymap.set('n', '<leader>a', function()
            harpoon:list():add()
        end)
        vim.keymap.set('n', '<leader>m', function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = 'Toggle Harpoon Menu List' })

        vim.keymap.set('n', '<leader>h', function()
            harpoon:list():select(1)
        end, { desc = 'Go to Harpoon 1' })
        vim.keymap.set('n', '<leader>j', function()
            harpoon:list():select(2)
        end, { desc = 'Go to Harpoon 2' })
        vim.keymap.set('n', '<leader>k', function()
            harpoon:list():select(3)
        end, { desc = 'Go to Harpoon 3' })
        vim.keymap.set('n', '<leader>l', function()
            harpoon:list():select(4)
        end, { desc = 'Go to Harpoon 4' })
    end,
}
