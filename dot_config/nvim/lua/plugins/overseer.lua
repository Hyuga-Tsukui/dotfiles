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
}
