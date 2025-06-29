return {
    {
        "mason-org/mason.nvim",
        cmd = { "Mason", "MasonUpdate" },
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local lsp_utils = require("utils.lsp")
            require("mason").setup({
                ensure_installed = lsp_utils.get_available_lsp_servers(),
                automatic_installation = true,
            })
        end,
    },
}
