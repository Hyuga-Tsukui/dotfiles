return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        picker = {
            layout = 'dropdown',
            formatters = { file = { truncate = 200 } },
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
                Snacks.picker.buffers({
                    on_show = function()
                        vim.cmd.stopinsert()
                    end,
                    layout = 'ivy_split',
                })
            end,
            desc = 'Pick Buffer',
        },
        {
            '<leader>pj',
            function()
                Snacks.picker.jumps({
                    on_show = function()
                        vim.cmd.stopinsert()
                    end,
                    layout = 'ivy_split',
                })
            end,
            desc = 'Pick Jumps',
        },
        {
            '<leader>ps',
            function()
                Snacks.picker.grep_word({
                    on_show = function()
                        vim.cmd.stopinsert()
                    end,
                    layout = 'ivy_split',
                })
            end,
            desc = 'Grep Word',
        },
        {
            '<leader>pr',
            function()
                Snacks.picker.recent()
            end,
            desc = 'Pick Recent File',
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
                Snacks.picker.grep_word({
                    on_show = function()
                        vim.cmd.stopinsert()
                    end,
                    layout = 'ivy_split',
                })
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
                Snacks.picker.diagnostics({
                    on_show = function()
                        vim.cmd.stopinsert()
                    end,
                    layout = 'ivy_split',
                })
            end,
            desc = 'Diagnostics',
        },
        {
            '<leader>nn',
            function()
                Snacks.picker.notifications({
                    on_show = function()
                        vim.cmd.stopinsert()
                    end,
                    layout = 'ivy_split',
                })
            end,
            desc = 'Notifications',
        },
        -- {
        --     'gr',
        --     function()
        --         Snacks.picker.lsp_references({
        --             on_show = function()
        --                 vim.cmd.stopinsert()
        --             end,
        --             layout = 'ivy_split',
        --         })
        --     end,
        --     desc = 'lsp references',
        -- },
        -- {
        --     'gd',
        --     function()
        --         Snacks.picker.lsp_definitions({
        --             on_show = function()
        --                 vim.cmd.stopinsert()
        --             end,
        --             layout = 'ivy_split',
        --         })
        --     end,
        --     desc = 'lsp definitions',
        -- },
    },
}
