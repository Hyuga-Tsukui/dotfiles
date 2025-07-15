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
            '<leader>ff',
            function()
                Snacks.picker.files()
            end,
            desc = 'Find Files',
        },
        {
            '<leader>fb',
            function()
                Snacks.picker.buffers()
            end,
            desc = 'Buffers',
        },
        {
            '<C-r>',
            function()
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-c>', true, false, true), 'n', false)
                Snacks.picker.command_history()
            end,
            mode = 'c',
            noremap = true,
            silent = true,
            desc = 'Command History',
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
