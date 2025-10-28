return {
    --@type vim.lsp.Config
    settings = {
        pyright = {
            disableOrganizeImports = true,
        },
        python = {
            analysis = {
                autoSearchPaths = true,
                autoImportCompletions = true,
                typeCheckingMode = 'off',
            },
        },
    },
}
