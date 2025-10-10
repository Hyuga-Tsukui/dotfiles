-- plugins/luasnip.lua
return {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    build = 'make install_jsregexp',
    event = { 'InsertEnter', 'CmdLineEnter' },
    opts = {
        keymap = {
            prest = 'super-tab',
            ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
            ['<C-b>'] = {},
            ['<C-f>'] = {},
        },
    },
    opt_extend = { 'sources.default' },
}
