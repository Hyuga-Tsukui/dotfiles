local function my_format()
    vim.lsp.buf.format({
        async = false,
        timeout_ms = 2000,
        filter = function(client)
            return client.name ~= "ts_ls"
        end,
    })
end
local function load_server_config(server_name)
    local ok, server_config = pcall(require, "plugins.lsp.servers" .. "." .. server_name)
    if ok then
        return server_config
    else
        return function()
            local lspconfig = require("lspconfig")
            lspconfig[server_name].setup({})
        end
    end
end
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
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({})
        end,
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
            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    local server_config = load_server_config(server_name)
                    server_config()
                end,
            })

            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
            vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

            -- after the language server attaches to the current buffer
            local g = vim.api.nvim_create_augroup("UserLspConfig", {})
            vim.api.nvim_create_autocmd("LspAttach", {
                group = g,
                callback = function(ev)
                    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                    local opts = { buffer = ev.buf }
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

                    local wk = require("which-key")
                    wk.add({
                        { "gd",        "<cmd>lua vim.lsp.buf.definition()<CR>",  desc = "Go to definition" },
                        { "gD",        "<cmd>lua vim.lsp.buf.declaration()<CR>", desc = "Go to declaration" },
                        { "gr",        "<cmd>lua vim.lsp.buf.references()<CR>",  desc = "Go to references" },
                        { "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>",      desc = "Rename" },
                    })

                    local client = vim.lsp.get_client_by_id(ev.data.client_id)
                    if client == nil then
                        return
                    end

                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_create_autocmd({ "BufWritePre" }, {
                            group = g,
                            buffer = ev.bufnr,
                            callback = function()
                                my_format()
                            end,
                        })
                        vim.keymap.set("n", "<space>f", my_format, opts)
                    end
                end,
            })
        end,
    },
}
