local function my_format()
    vim.lsp.buf.format({
        async = false,
        timeout_ms = 2000,
        filter = function(client)
            return client.name ~= "ts_ls"
        end,
    })
end

-- 保存時のフォーマットを無効化するクライアントのリストを設定する
local disable_auto_format_clients = {
    "ts_ls", -- js,tsはフォーマッターにbiomeやprettierを使うことが一般的なので無効化する
}
return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({})
        end,
        cmd = { "Mason" },
        lazy = true,
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        cond = function()
            -- 現在のバッファのファイルタイプが特定のもの (例: NvimTree) でないことを確認
            local exclude_filetypes = { "NvimTree" }
            return not vim.tbl_contains(exclude_filetypes, vim.bo.filetype)
        end,
        config = function()
            vim.lsp.set_log_level("ERROR")

            vim.lsp.enable({
                "lua_ls",
                "biome",
            })

            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
            vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { silent = true, desc = "quickfix diagnostics" })

            -- after the language server attaches to the current buffer
            local g = vim.api.nvim_create_augroup("UserLspConfig", {})
            vim.api.nvim_create_autocmd("LspAttach", {
                group = g,
                callback = function(ev)
                    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                    local opts = { buffer = ev.buf, silent = true }
                    vim.keymap.set(
                        "n",
                        "gD",
                        vim.lsp.buf.declaration,
                        vim.tbl_extend("force", opts, { desc = "lsp declaration" })
                    )
                    vim.keymap.set(
                        "n",
                        "gd",
                        vim.lsp.buf.definition,
                        vim.tbl_extend("force", opts, { desc = "lsp definition" })
                    )
                    vim.keymap.set(
                        "n",
                        "<space>rn",
                        vim.lsp.buf.rename,
                        vim.tbl_extend("force", opts, { desc = "lsp rename" })
                    )
                    vim.keymap.set(
                        "n",
                        "gr",
                        vim.lsp.buf.references,
                        vim.tbl_extend("force", opts, { desc = "lsp references" })
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>ls",
                        vim.lsp.buf.signature_help,
                        vim.tbl_extend("force", opts, { desc = "lsp signature_help" })
                    )

                    local client = vim.lsp.get_client_by_id(ev.data.client_id)

                    if client == nil then
                        return
                    end

                    -- 保存時の自動フォーマットの設定
                    if
                        not vim.tbl_contains(disable_auto_format_clients, client.name)
                        and client.supports_method("textDocument/formatting")
                    then
                        vim.api.nvim_create_autocmd({ "BufWritePre" }, {
                            group = g,
                            buffer = ev.bufnr,
                            callback = function()
                                my_format()
                            end,
                        })
                    end
                end,
            })
        end,
    },
}
