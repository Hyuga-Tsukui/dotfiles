-- plugins/luasnip.lua
return {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    lazy = false,
    config = function()
        local ls = require("luasnip")

        --------------------------------------------------------------------------
        -- 基本設定
        --------------------------------------------------------------------------
        ls.config.set_config({
            history = true, -- 展開後も履歴を保持
            updateevents = "TextChanged,TextChangedI",
            enable_autosnippets = false,
            delete_check_events = "TextChanged",
        })

        --------------------------------------------------------------------------
        -- スニペットのロード
        --------------------------------------------------------------------------
        require("luasnip.loaders.from_lua").lazy_load({
            paths = vim.fn.stdpath("config") .. "/luasnip/snippets",
        })
    end,
}
