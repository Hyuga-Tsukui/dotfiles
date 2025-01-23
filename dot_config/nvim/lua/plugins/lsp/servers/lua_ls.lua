return function()
    local lspconfig = require("lspconfig")
    lspconfig.lua_ls.setup({
        settings = {
            Lua = {
                diagnostics = {
                    globals = {
                        "vim",
                    },
                },
                workspace = {
                    maxPreload = 10000, -- プリロードするファイル数を増やす
                    preloadFileSize = 5000, -- 最大ファイルサイズをKB単位で設定
                },
            },
        },
    })
end
