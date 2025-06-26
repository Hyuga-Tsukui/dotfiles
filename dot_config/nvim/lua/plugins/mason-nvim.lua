local language_servers = {
    "lua_ls",
    "gopls",
    "typos_lsp",
    "ts_ls",
    "terraformls",
    "ocamllsp",
    "nil_ls",
    "pylsp",
    "ruff",
}
local format_servers = {
    "ocamlformat",
    "stylua",
    "gofmt",
    "goimports",
    "terraform_fmt",
    "prettierd",
    "sqlfmt",
    "nixpkgs-fmt",
    "black",
}
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
            require("mason").setup({})
            require("mason-null-ls").setup({
                -- ensure_installed = format_servers,
            })
        end,
    },
}
