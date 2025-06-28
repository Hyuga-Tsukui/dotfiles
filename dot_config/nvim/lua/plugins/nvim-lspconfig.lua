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
            local exclude_filetypes = { "NvimTree" }
            return not vim.tbl_contains(exclude_filetypes, vim.bo.filetype)
        end,
        config = function()
            vim.lsp.set_log_level("ERROR")

            -- TODO: auto enable lsp servers
            vim.lsp.enable({
                "lua_ls",
                "biome",
                "pylsp",
                "ruff",
            })

            local g = vim.api.nvim_create_augroup("UserLspConfig", {})
            vim.api.nvim_create_autocmd("LspAttach", {
                group = g,
                callback = function(ev)
                    local opts = { buffer = ev.buf, silent = true }

                    vim.keymap.set("n", "[d", function()
                        vim.diagnostic.jump({
                            count = -1,
                        })
                    end, vim.tbl_extend("force", opts, { desc = "previous diagnostic" }))
                    vim.keymap.set("n", "]d", function()
                        vim.diagnostic.jump({
                            count = 1,
                        })
                    end, vim.tbl_extend("force", opts, { desc = "next diagnostic" }))
                    vim.keymap.set(
                        "n",
                        "<space>q",
                        vim.diagnostic.setloclist,
                        vim.tbl_extend("force", opts, { desc = "diagnostic setloclist" })
                    )

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

                    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
                    local client = vim.lsp.get_client_by_id(ev.data.client_id)

                    if client == nil then
                        vim.notify(
                            "LSP client not found for buffer " .. ev.buf,
                            vim.log.levels.ERROR,
                            { title = "LSP Error" }
                        )
                        return
                    end

                    if vim.tbl_contains(disable_auto_format_clients, client.name) then
                        vim.notify(
                            "Auto-formatting disabled for client: " .. client.name,
                            vim.log.levels.WARN,
                            { title = "LSP Warning" }
                        )
                        return
                    end

                    if not client:supports_method("textDocument/formatting") then
                        return
                    end

                    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
                        group = g,
                        buffer = ev.buf,
                        callback = function()
                            vim.lsp.buf.format({
                                async = false,
                                timeout_ms = 2000,
                            })
                        end,
                    })
                end,
            })
        end,
    },
}
