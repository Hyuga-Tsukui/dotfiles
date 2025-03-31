-- REF: https://github.com/zbirenbaum/copilot-cmp?tab=readme-ov-file#tab-completion-configuration-highly-recommended
local has_words_before = function()
    if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt" then
        return false
    end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    local text = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
    return col ~= 0 and text:sub(col, col):match("%s") == nil
end

return {
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter" },
        keys = { { ":", mode = "n" }, { "/", mode = "n" } },
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            {
                "zbirenbaum/copilot-cmp",
                config = true,
            },
            "onsails/lspkind.nvim",
        },
        config = function()
            -- Setup lspkind icons including Copilot
            local lspkind = require("lspkind")
            lspkind.init({
                symbol_map = {
                    Copilot = "",
                },
            })
            vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

            local lua_snip = require("luasnip")
            local cmp = require("cmp")
            cmp.setup({
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                sources = cmp.config.sources({
                    { name = "copilot",  group_index = 1 },
                    { name = "nvim_lsp", group_index = 2 },
                    { name = "luasnip",  group_index = 2 },
                    { name = "buffer" },
                    { name = "path" },
                }),
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                        elseif lua_snip.expand_or_jumpable() then
                            lua_snip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                        elseif lua_snip.jumpable(-1) then
                            lua_snip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<C-e>"] = cmp.mapping.abort(),
                }),

                sorting = {
                    priority_weight = 2,
                    comparators = {
                        require("copilot_cmp.comparators").prioritize,

                        -- Below is the default comparator list and order for nvim-cmp
                        cmp.config.compare.offset,
                        -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
                        cmp.config.compare.exact,
                        cmp.config.compare.score,
                        cmp.config.compare.recently_used,
                        cmp.config.compare.locality,
                        cmp.config.compare.kind,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
                },

                formatting = {
                    format = lspkind.cmp_format({
                        with_text = true,
                        maxwidth = 50,
                    }),
                },
            })

            cmp.setup.cmdline("/", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    {
                        name = "cmdline",
                        option = {
                            ignore_cmds = { "Man", "!" },
                        },
                    },
                }),
            })
        end,
    },
}
