return {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'VeryLazy',
    build = ':Copilot auth',
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
        vim.defer_fn(function()
            vim.cmd('Copilot auth') -- 認証確認だけ先に行う
        end, 2000)
    end,
}
