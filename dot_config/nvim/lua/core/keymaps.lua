vim.g.mapleader = ' '

-- 検索ハイライトを消す
vim.keymap.set('n', '<leader>nh', ':nohl<CR>', { noremap = true, silent = true })

-- visualモードで選択範囲を動かす
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- diagnosticをquickfixにセット
vim.keymap.set('n', 'qd', ':lua vim.diagnostic.setloclist()<CR>')

-- 最後の検索結果をquickfixにセット
vim.keymap.set(
    'n',
    '?',
    '<cmd>silent vimgrep//gj%|copen<cr>',
    { desc = 'Populate latest search result to quickfix list' }
)

vim.keymap.set('n', 'p', 'p`]', { silent = true })
vim.keymap.set('n', 'P', 'P`]', { silent = true })

vim.keymap.set('x', '<', '<gv')
vim.keymap.set('x', '>', '>gv')

-- ref: https://zenn.dev/kawarimidoll/books/6064bf6f193b51/viewer/b14229
vim.opt.grepprg = table.concat({
    'rg',
    '--vimgrep',
    '--trim',
    '--hidden',
    [[--glob='!.git']],
    [[--glob='!*.lock']],
    [[--glob='!*-lock.json']],
    [[--glob='!*generated*']],
}, ' ')
vim.opt.grepformat = '%f:%l:%c:%m'

-- ref: `:NewGrep` in `:help grep`
vim.api.nvim_create_user_command('Grep', function(arg)
    local grep_cmd = 'silent grep! ' .. (arg.bang and '--fixed-strings -- ' or '') .. vim.fn.shellescape(arg.args, true)
    vim.cmd(grep_cmd)
    if vim.fn.getqflist({ size = true }).size > 0 then
        vim.cmd.copen()
    else
        vim.notify('no matches found', vim.log.levels.WARN)
        vim.cmd.cclose()
    end
end, { nargs = '+', bang = true, desc = 'Enhounced grep' })
