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
        "williamboman/mason.nvim",
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
            require("mason-lspconfig").setup({
                -- ensure_installed = language_servers,
            })
            require("mason-null-ls").setup({
                -- ensure_installed = format_servers,
            })
        end,
    },
    -- {
    --     "dense-analysis/ale",
    --     config = function()
    --         -- Pythonのformatterにruffを設定
    --         vim.g.ale_fixers = {
    --             python = { "ruff", "black" },
    --         }
    --         vim.g.ale_linters = {
    --             python = { "ruff" },
    --         }
    --         vim.g.ale_fix_on_save = 1
    --         vim.fn.expand("~/.local/share/nvim/mason/bin/ruff")
    --         vim.fn.expand("~/.local/share/nvim/mason/bin/black")
    --     end,
    -- },
}
