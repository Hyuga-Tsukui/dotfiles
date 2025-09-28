return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        picker = {
            enabled = true,
            sources = {
                files = {
                    exclude = {
                        '/undo/',
                    },
                },
                diagnostics = {
                    exclude = {
                        '/undo/',
                    },
                },
            },
        },
        notifier = {},
    },
    keys = {
        {
            '<leader>lg',
            function()
                Snacks.lazygit()
            end,
            desc = 'Lazygit',
        },
        {
            '<leader>gl',
            function()
                Snacks.lazygit.log()
            end,
            desc = 'Lazygit Log',
        },
        {
            '<leader>gL',
            function()
                Snacks.picker.git_log_line()
            end,
            desc = 'Git Log Line',
        },
        {
            '<leader>gbr',
            function()
                Snacks.picker.git_branches({ layout = 'select' })
            end,
            desc = 'Switch Git Branches',
        },
        {
            '<leader>gs',
            function()
                Snacks.picker.git_status()
            end,
            desc = 'Git Status',
        },
        {
            '<leader>gd',
            function()
                Snacks.picker.git_diff()
            end,
        },
        {
            '<leader>/',
            function()
                Snacks.picker.grep()
            end,
            desc = 'Grep',
        },
        {
            '<leader>pf',
            function()
                Snacks.picker.files()
            end,
            desc = 'Pick File',
        },
        {
            '<leader>pb',
            function()
                Snacks.picker.buffers()
            end,
            desc = 'Pick Buffer',
        },
        {
            '<leader>ps',
            function()
                Snacks.picker.grep_word()
            end,
            desc = 'Grep Word',
        },
        {
            '<leader>pk',
            function()
                Snacks.picker.keymaps({ layout = 'ivy' })
            end,
            desc = 'Search Keymaps (Snacks Picker)',
        },
        {
            '<leader>pws',
            function()
                Snacks.picker.grep_word()
            end,
            desc = 'Search Visual Selection or Word',
            mode = { 'n', 'x' },
        },
        {
            '<leader>sc',
            function()
                Snacks.picker.command_history({
                    on_select = function(item)
                        print('Executing command: ' .. item.value)
                        vim.api.nvim_feedkeys(';' .. item.value .. '\n', 'n', false)
                    end,
                })
            end,
            desc = 'Commands Picker',
        },
        {
            '<leader>ds',
            function()
                Snacks.picker.diagnostics()
            end,
            desc = 'Diagnostics',
        },
        {
            '<leader>nn',
            function()
                Snacks.picker.notifications()
            end,
            desc = 'Notifications',
        },
    },
}
