return function()
    local lspconfig = require("lspconfig")
    lspconfig.terraformls.setup({
        on_attach = function(client, _)
            client.server_capabilities.semanticTokensProvider = nil
        end,
    })
end
