return {
    'stevearc/overseer.nvim',
    opt = {},

    cmd = {
        'OverseerRun',
        'OverseerToggle',
        'OverseerClose',
        'OverseerRestart',
        'OverseerDelete',
        'OverseerTaskAction',
    },

    config = function()
        require('overseer').setup({})
    end,
    keys = {
        { '<leader>tl', '<cmd>OverseerRun<cr>', desc = 'Overseer Run' },
        { '<leader>tt', '<cmd>OverseerToggle<cr>', desc = 'Overseer Toggle' },
        { '<leader>tc', '<cmd>OverseerClose<cr>', desc = 'Overseer Close' },
        { '<leader>tr', '<cmd>OverseerRestart<cr>', desc = 'Overseer Restart' },
        { '<leader>td', '<cmd>OverseerDelete<cr>', desc = 'Overseer Delete' },
    },
}
