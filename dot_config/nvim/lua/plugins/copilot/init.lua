return {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    build = ':Copilot auth',
    dependencies = {
        'https://github.com/copilotlsp-nvim/copilot-lsp',
    },
    config = function()
        -- REF: integration nvim-cmp https://github.com/zbirenbaum/copilot-cmp
        require('copilot').setup({
            suggestion = { enabled = false },
            panel = { enabled = false },

            -- enable when git commit editor is opened
            filetypes = {
                gitcommit = true,
                yaml = true,
            },
        })
    end,
}
