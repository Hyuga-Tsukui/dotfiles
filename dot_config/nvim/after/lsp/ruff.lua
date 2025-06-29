return {
    ---@type vim.lsp.Config
    settings = {
        ruff = {
            init_options = {
                fix = true,
                settings = {
                    configuration = {
                        lint = {
                            ["extend-select"] = { "TID251", "I" },
                            fix = true,
                        },
                        format = {
                            ["quote-style"] = "single",
                        },
                    },
                },
            },
        },
    },
}
