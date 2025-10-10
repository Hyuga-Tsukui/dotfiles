return {
    {
        'saghen/blink.cmp',
        version = '1.*',

        event = { 'InsertEnter', 'CmdLineEnter' },
        dependencies = {
            'fang2hou/blink-copilot',
            'rafamadriz/friendly-snippets',
            'L3MON4D3/LuaSnip',
        },

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            snippets = { preset = 'luasnip' },
            completion = {
                menu = {
                    border = 'single',
                    draw = {
                        columns = {
                            { 'kind_icon', 'label', gap = 1 },
                        },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 0,
                    treesitter_highlighting = true,
                    window = { border = 'single' },
                },
                accept = { auto_brackets = { enabled = true } },
                ghost_text = { enabled = true },
                list = {
                    selection = {
                        preselect = true,
                        auto_insert = false,
                    },
                },
            },
            sources = {
                default = {
                    'snippets',
                    'lsp',
                    'buffer',
                    'path',
                    'copilot',
                },
                per_filetype = {
                    markdown = { 'lsp', 'path', 'copilot' },
                },
                providers = {
                    copilot = {
                        name = 'copilot',
                        module = 'blink-copilot',
                        score_offset = 100,
                        async = true,
                    },
                },
            },
            keymap = {
                preset = 'enter',
                ['<Tab>'] = {
                    function(cmp)
                        return cmp.select_next()
                    end,
                    'snippet_forward',
                    'fallback',
                },
                ['<S-Tab>'] = {
                    function(cmp)
                        return cmp.select_prev()
                    end,
                    'snippet_backward',
                    'fallback',
                },
                ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
                ['<C-e>'] = { 'hide', 'fallback' },
                ['<C-b>'] = {},
                ['<C-f>'] = {},
            },
            signature = {
                enabled = true,
                window = { border = 'single' },
            },
        },
        opts_extend = { 'sources.default' },
        config = function(_, opts)
            require('blink.cmp').setup(opts)
            require('luasnip.loaders.from_vscode').lazy_load()
        end,
    },
}
