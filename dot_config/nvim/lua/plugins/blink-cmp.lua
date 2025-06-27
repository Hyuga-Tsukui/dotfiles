return {
    {
        "saghen/blink.cmp",
        version = "1.*",

        dependencies = { "fang2hou/blink-copilot" },

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            completion = {
                documentation = { auto_show = true, auto_show_delay_ms = 100 },
                accept = { auto_brackets = { enabled = true } },
                ghost_text = { enabled = false },
            },
            sources = {
                default = {
                    "lsp",
                    "buffer",
                    "snippets",
                    "path",
                    "copilot",
                },
                providers = {
                    copilot = {
                        name = "copilot",
                        module = "blink-copilot",
                        score_offset = 100,
                        async = true,
                    },
                },
            },
            keymap = {
                ["<ESC>"] = { "hide", "fallback" },
                ["<CR>"] = { "accept", "fallback" },
                ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
                ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
                ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
            },
        },
        opts_extend = { "sources.default" },
    },
}
