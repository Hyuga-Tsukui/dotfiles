local function my_format()
    vim.lsp.buf.format({
        async = false,
        timeout_ms = 2000,
        filter = function(client)
            return client.name ~= "tsserver"
        end,
    })
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
            local lspconfig = require("lspconfig")
            require("mason-lspconfig").setup_handlers({
                -- 1. デフォルトのハンドラー
                -- すべてのサーバーに対して共通の設定を適用
                function(server_name)
                    lspconfig[server_name].setup({})
                end,

                -- 2. 特定のサーバーに対するカスタム設定
                -- 例：rust_analyzer の場合、rust-tools を使用した設定
                -- ["rust_analyzer"] = function()
                -- 	require("rust-tools").setup({})
                -- end,
                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup({
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = {
                                        "vim",
                                    },
                                },
                            },
                        },
                    })
                end,

                ["terraformls"] = function()
                    lspconfig.terraformls.setup({
                        on_attach = function(client, _)
                            client.server_capabilities.semanticTokensProvider = nil
                        end,
                    })
                end,

                ["typos_lsp"] = function()
                    lspconfig.typos_lsp.setup({
                        init_options = {
                            config = "~/.config/typos/.typos.toml",
                        },
                    })
                end,

                ["biome"] = function()
                    lspconfig.biome.setup({
                        cmd = { "npx", "biome", "lsp-proxy" },
                        on_new_config = function(new_config, new_root_dir)
                            -- 環境変数で biome.json を指定
                            new_config.cmd_env = {
                                BIOME_CONFIG = new_root_dir .. "/biome.json",
                            }
                        end,
                        root_dir = function(fname)
                            local util = require("lspconfig.util")
                            -- biome.json を探すロジック
                            return util.root_pattern("biome.json")(fname) -- biome.json を基準にルートディレクトリを設定
                                or util.find_git_ancestor(fname) -- .git を基準にルートディレクトリを設定
                                or util.path.dirname(fname) -- デフォルトは現在のファイルのディレクトリ
                        end,
                    })
                end,
            })

            -- Lsp Keymaps.
            -- global.
            -- vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
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
                    vim.keymap.set("n", "<space>k", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

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
                        vim.api.nvim_create_user_command("Format", function()
                            my_format()
                        end, {})
                    end
                end,
            })
        end,
    },
}
