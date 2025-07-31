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
    },
    keys = {
        {
            '<leader>gl',
            function()
                Snacks.picker.git_log()
            end,
            desc = 'Git Log',
        },
        {
            '<leader>gL',
            function()
                Snacks.picker.git_log_line()
            end,
            desc = 'Git Log Line',
        },
        {
            '<leader>gb',
            function()
                Snacks.picker.git_branches()
            end,
            desc = 'Git Branches',
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
            '<leader>fs',
            function()
                Snacks.picker.files()
            end,
            desc = 'Search File',
        },
        {
            '<leader>bs',
            function()
                Snacks.picker.buffers()
            end,
            desc = 'Buffers Picker',
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
            '<leader>z',
            function()
                Snacks.zen()
            end,
            desc = 'Zen Mode',
        },
    },
}
