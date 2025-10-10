return {
    'https://github.com/vim-jp/vimdoc-ja',
    config = function()
        vim.opt.helplang:prepend('ja')
    end,
    event = 'VeryLazy',
}
