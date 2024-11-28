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

        -- JavaScript プロジェクト用のフォーマッター選択
        local function javascript_project()
            local biome_config = vim.fn.findfile("biome.json", ".;")
            if biome_config ~= "" and include({ "javascript", "typescript" }, vim.bo.filetype) then
                return {
                    null_ls.builtins.formatting.biome.with({
                        extra_args = { "--config", biome_config }, -- biome.json を明示的に指定
                    }),
                }
            else
                return {
                    null_ls.builtins.formatting.prettierd.with({
                        cwd = function()
                            return vim.fn.getcwd()
                        end,
                    }),
                }
            end
        end

        -- null-ls のセットアップ
        null_ls.setup({
            -- sources の結合
            sources = vim.list_extend({
                null_ls.builtins.formatting.terraform_fmt, -- デフォルト
            }, javascript_project()),          -- JavaScript プロジェクト用のフォーマッター
            on_attach = function(client, bufnr)
                vim.keymap.set("n", "<space>f", function()
                    vim.lsp.buf.format({ async = true })
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
                end
            end,
        })
    end,
}
