return {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = vim.split(package.path, ";"),
            },
            hints = {
                enable = true,
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                maxPreload = 10000,
                preloadFileSize = 5000,
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            completion = {
                callSnippet = "Replace",
            },
            telemetry = {
                enable = false,
            },
        },
    },
}
