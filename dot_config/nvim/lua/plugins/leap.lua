return {
    'https://github.com/ggandor/leap.nvim',
    key = { 's', 'S' },
    config = function()
        vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
        local leap = require('leap')
        leap.opts.case_sensitive = true
        leap.opts.preview_filter = function(ch0, ch1, ch2)
            return not (ch1:match('%s') or ch0:match('%a') and ch1:match('%a') and ch2:match('%a'))
        end
        vim.keymap.set('n', 's', '<Plug>(leap-forward-to)', { noremap = false })
        vim.keymap.set('n', 'S', '<Plug>(leap-backward-to)', { noremap = false })
        require('leap.user').set_repeat_keys('<enter>', '<backspace>')
    end,
}
