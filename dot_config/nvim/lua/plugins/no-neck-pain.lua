return {
    'shortcuts/no-neck-pain.nvim',
    keys = {
        { '<leader>zz', ':NoNeckPain<CR>', desc = 'Toggle No Neck Pain' },
    },
    config = function()
        require('no-neck-pain').setup({
            width = 80,
            buffers = {
                right = {
                    enabled = false,
                },
                scratchPad = {
                    enabled = true,
                    location = '~/notes',
                },
                bo = {
                    filetype = 'md',
                },
            },
            integrations = {
                NvimTree = {
                    position = 'left',
                    reopen = false,
                },
            },
        })
    end,
}
