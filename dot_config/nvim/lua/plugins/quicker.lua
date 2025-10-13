return {
    'https://github.com/stevearc/quicker.nvim',
    ft = 'qf',
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
    config = function(_, opts)
        local quicker = require('quicker')
        vim.keymap.set('n', 'mq', function()
            quicker.toggle()
            quicker.refresh()
        end, { desc = 'Toggle quickfix' })
        quicker.setup({
            keys = {
                {
                    '>',
                    function()
                        require('quicker').expand({ before = 2, after = 2, add_to_existing = true })
                    end,
                    desc = 'Expand quickfix context',
                },
                {
                    '<',
                    function()
                        require('quicker').collapse()
                    end,
                    desc = 'Collapse quickfix context',
                },
            },
        })
    end,
}
