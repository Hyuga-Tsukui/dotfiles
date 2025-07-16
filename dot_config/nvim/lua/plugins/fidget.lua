return {
    'j-hui/fidget.nvim',
    opts = {
        notification = {
            override_vim_notify = true,
            window = {
                relative = 'editor',
                align = 'top',
                x_padding = 10000,
                winblend = 20,
                border = {
                    { '╭', 'FloatBorderFidget' },
                    { '─', 'FloatBorderFidget' },
                    { '╮', 'FloatBorderFidget' },
                    { '│', 'FloatBorderFidget' },
                    { '╯', 'FloatBorderFidget' },
                    { '─', 'FloatBorderFidget' },
                    { '╰', 'FloatBorderFidget' },
                    { '│', 'FloatBorderFidget' },
                },
            },
        },
        progress = {
            display = {
                done_ttl = 3,
            },
        },
    },
    config = function(_, opts)
        vim.api.nvim_set_hl(0, 'FloatBorderFidget', {
            fg = '#ffffff', -- 枠線の色
            -- bg = '#1e1e2e', -- 通知ウィンドウの背景に合わせる
        })
        require('fidget').setup(opts)
    end,
    lazy = false,
}
