return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-null-ls.nvim",
    },
    event = { "BufRead", "BufNewFile" },
    config = function()
        local null_ls = require("null-ls")
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.ocamlformat.with({
                    cwd = function(params)
                        local conf = vim.fn.findfile(".ocamlformat", params.root)
                        if conf then
                            return vim.fn.fnamemodify(conf, ":p:h")
                        end
                    end,
                }),
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.gofmt,
                null_ls.builtins.formatting.goimports,
                null_ls.builtins.formatting.terraform_fmt,

                null_ls.builtins.formatting.prettierd.with({}),

                null_ls.builtins.formatting.sqlfmt,
            },
            on_attach = function(client, bufnr)
                vim.keymap.set("n", "<space>f", function()
                    vim.lsp.buf.format({
                        async = true,
                        filter = function(c)
                            return c.name == "null-ls"
                        end,
                    })
                end, { buffer = bufnr })

                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ async = false })
                        end,
                    })

                    vim.api.nvim_create_autocmd("InsertLeave", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ async = true })
                        end,
                    })
                end
            end,
        })
    end,
}
