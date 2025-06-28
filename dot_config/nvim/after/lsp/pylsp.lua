return {
    settings = {
        pylsp = {
            plugins = {
                -- pep8 is a Python style guide checker
                pycodestyle = {
                    enabled = true,
                    ignore = { "E501" }, -- Ignore line length errors
                },
                mccabe = {
                    enabled = false,
                },
            },
        },
    },
}
