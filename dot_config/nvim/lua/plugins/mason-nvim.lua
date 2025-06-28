return {
    {
        "mason-org/mason.nvim",
        cmd = "Mason",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            {
                "williamboman/mason-null-ls.nvim",
                dependencies = "none-ls.nvim",
            },
        },
        config = function()
            local lsp_utils = require("utils.lsp")
            require("mason").setup({
                ensure_installed = lsp_utils.get_available_lsp_servers(),
                automatic_installation = true,
            })
            require("mason-null-ls").setup({})
        end,
    },
}
