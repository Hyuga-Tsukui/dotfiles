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
            workspace = {
                checkThirdParty = false,
                maxPreload = 10000,
                preloadFileSize = 5000,
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
