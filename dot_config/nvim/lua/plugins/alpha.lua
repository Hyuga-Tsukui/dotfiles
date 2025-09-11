local arts = {
    'assets.rei-art',
    'assets.z-gundom',
}
math.randomseed(os.time())
local choice = arts[math.random(#arts)]

local art = require(choice)

return {
    'goolord/alpha-nvim',
    -- dependencies = { 'echasnovski/mini.icons' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local dashboard = require('alpha.themes.dashboard')

        dashboard.section.buttons.val = {
            dashboard.button('f', '  Find file', ":lua Snacks.dashboard.pick('files') <CR>"),
            dashboard.button('r', '  Recent files', ":lua Snacks.dashboard.pick('oldfiles') <CR>"),
            dashboard.button('l', '󰒲  Lazy', ':Lazy<CR>'),
            dashboard.button('q', '  Quit', ':qa<CR>'),
        }

        dashboard.section.header = art
        dashboard.opts.layout = {
            dashboard.section.header,
            { type = 'padding', val = 2 },
            dashboard.section.buttons,
            { type = 'padding', val = 1 },
            dashboard.section.footer,
        }

        require('alpha').setup(dashboard.opts)
    end,
}
