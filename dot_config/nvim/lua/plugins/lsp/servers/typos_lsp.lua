return function()
    local lspconfig = require("lspconfig")
    lspconfig.typos_lsp.setup({
        init_options = {
            config = "~/.config/typos/.typos.toml",
        },
    })
end
