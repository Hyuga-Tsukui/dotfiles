-- 保存時のフォーマットを無効化するクライアントのリストを設定する
local disable_auto_format_clients = {
    'ts_ls', -- js,tsはフォーマッターにbiomeやprettierを使うことが一般的なので無効化する
}

-- REF: neovim-lspconfig + Biome で保存時に import の整理をする https://zenn.dev/izumin/articles/b8046e64eaa2b5
---@param client vim.lsp.Client
---@param bufnr integer
---@param cmd string
local function synchronize_code_action(client, bufnr, cmd)
    local enc = client.offset_encoding or 'utf-16'
    local params = {
        textDocument = vim.lsp.util.make_text_document_params(bufnr),
        range = {
            start = { line = 0, character = 0 },
            ['end'] = { line = vim.api.nvim_buf_line_count(bufnr), character = 0 },
        },
        context = {
            only = { cmd },
            diagnostics = {},
        },
    }
    params.context = { only = { cmd }, diagnostics = {} }
    local res = client:request_sync('textDocument/codeAction', params, 3000, bufnr)
    local results = res and res.result or {}
    for _, action in ipairs(results) do
        if not action.edit and client:supports_method('codeAction/resolve') then
            local resolved = client:request_sync('codeAction/resolve', action, 1000)
            if resolved and resolved.result and resolved.result.edit then
                vim.lsp.util.apply_workspace_edit(resolved.result.edit, enc)
            end
        elseif action.edit then
            vim.lsp.util.apply_workspace_edit(action.edit, enc)
        end
    end
end

---@param client vim.lsp.Client
---@param bufnr integer
local synchronize_organize_imports = function(client, bufnr)
    synchronize_code_action(client, bufnr, 'source.organizeImports')
end

---@param client vim.lsp.Client
---@param bufnr integer
local synchronize_format = function(client, bufnr)
    vim.lsp.buf.format({
        buffer = bufnr,
        async = false,
        name = client.name,
        timeout_ms = 5000,
    })
end

local save_handlers_by_client_name = {
    ruff = { synchronize_organize_imports, synchronize_format },
    sqls = { synchronize_format },
    biome = { synchronize_format },
    ['null-ls'] = { synchronize_format },
}

return {
    {
        'https://github.com/neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        cond = function()
            local exclude_filetypes = { 'NvimTree' }
            return not vim.tbl_contains(exclude_filetypes, vim.bo.filetype)
        end,
        config = function()
            vim.lsp.log.set_level('ERROR')
            local g = vim.api.nvim_create_augroup('UserLspConfig', {})

            -- TODO: after/lsp/ruff.luaに移行する
            -- Lspへの読み込みがなぜか、自動解決の場合とここで書く場合で挙動が異なる
            -- ---@type vim.lsp.Config
            -- vim.lsp.config('ruff', {})

            local lsp_utils = require('utils.lsp')
            vim.lsp.enable(lsp_utils.get_available_lsp_servers())

            vim.api.nvim_create_autocmd('LspAttach', {
                group = g,
                callback = function(ev)
                    local opts = { buffer = ev.buf, silent = true }

                    vim.keymap.set('n', '[d', function()
                        vim.diagnostic.jump({
                            count = -1,
                        })
                    end, vim.tbl_extend('force', opts, { desc = 'previous diagnostic' }))
                    vim.keymap.set('n', ']d', function()
                        vim.diagnostic.jump({
                            count = 1,
                        })
                    end, vim.tbl_extend('force', opts, { desc = 'next diagnostic' }))
                    vim.keymap.set(
                        'n',
                        '<space>q',
                        vim.diagnostic.setloclist,
                        vim.tbl_extend('force', opts, { desc = 'diagnostic setloclist' })
                    )

                    vim.keymap.set(
                        'n',
                        'gD',
                        vim.lsp.buf.declaration,
                        vim.tbl_extend('force', opts, { desc = 'lsp declaration' })
                    )
                    vim.keymap.set(
                        'n',
                        'gd',
                        vim.lsp.buf.definition,
                        vim.tbl_extend('force', opts, { desc = 'lsp definition' })
                    )
                    vim.keymap.set(
                        'n',
                        '<space>rn',
                        vim.lsp.buf.rename,
                        vim.tbl_extend('force', opts, { desc = 'lsp rename' })
                    )
                    vim.keymap.set(
                        'n',
                        'gr',
                        vim.lsp.buf.references,
                        vim.tbl_extend('force', opts, { desc = 'lsp references' })
                    )
                    vim.keymap.set(
                        'n',
                        '<leader>ls',
                        vim.lsp.buf.signature_help,
                        vim.tbl_extend('force', opts, { desc = 'lsp signature_help' })
                    )
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = 'lsp hover' }))

                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
                    local client = vim.lsp.get_client_by_id(ev.data.client_id)

                    if client == nil then
                        return
                    end

                    if vim.tbl_contains(disable_auto_format_clients, client.name) then
                        return
                    end

                    if not client:supports_method('textDocument/formatting') then
                        return
                    end

                    vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
                        group = g,
                        buffer = ev.buf,
                        ---@param args { buf: integer }
                        callback = function(args)
                            local bufnr = args.buf
                            local should_sleep = false

                            local handlers = save_handlers_by_client_name[client.name]
                            for _, handler in pairs(handlers or {}) do
                                if should_sleep then
                                    vim.api.nvim_command('sleep 10ms')
                                else
                                    should_sleep = true
                                end
                                handler(client, bufnr)
                            end
                        end,
                    })
                end,
            })
        end,
    },
}
