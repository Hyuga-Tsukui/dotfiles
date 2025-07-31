return {
    ---@type vim.lsp.Config
    settings = {
        pylsp = {
            plugins = {
                -- pep8 is a Python style guide checker
                pycodestyle = {
                    enabled = true,
                    ignore = { 'E501', 'W503' }, -- Ignore line length errors
                },
                mccabe = {
                    enabled = false,
                },
                autopep8 = {
                    enabled = false,
                },
                yapf = {
                    enabled = false,
                },
                pyflakes = {
                    enabled = true,
                },
            },
        },
    },
}
