local function include(array, value)
    for _, v in ipairs(array) do
        if v == value then
            return true
        end
    end
    return false
end
return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-null-ls.nvim",
    },
    event = { "BufRead", "BufNewFile" },
    config = function()
        require("mason").setup()
        require("mason-null-ls").setup({
            handlers = {
                prettierd = function() end, -- prettierd の自動セットアップを無効化
                biome = function() end, -- biome の自動セットアップを無効化
            },
        })

        local null_ls = require("null-ls")
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

        -- null-ls のセットアップ
        null_ls.setup({
            -- sources の結合
            sources = {
                null_ls.builtins.formatting.terraform_fmt, -- デフォルト
            },                                 -- JavaScript プロジェクト用のフォーマッター
            on_attach = function(client, bufnr)
                -- vim.keymap.set("n", "<space>f", function()
                -- vim.lsp.buf.format({ async = true })
                -- end, { buffer = bufnr })

                -- if client.supports_method("textDocument/formatting") then
                --     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                --     vim.api.nvim_create_autocmd("BufWritePre", {
                --         group = augroup,
                --         buffer = bufnr,
                --         callback = function()
                --             vim.lsp.buf.format({ async = false })
                --         end,
                --     })
                -- end
            end,
        })
    end,
}
