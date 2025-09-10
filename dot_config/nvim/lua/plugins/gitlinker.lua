-- GitLinkコマンドで、Vモードで選択した行のGitHubリンクをクリップボードにコピーする
-- GitLink!とすることで、ブラウザで開くことも可能
-- REF: https://github.com/linrongbin16/gitlinker.nvim
return {
    'linrongbin16/gitlinker.nvim',
    cmd = 'GitLink',
    opts = {},
    keys = {
        { '<leader>gy', '<cmd>GitLink<cr>', mode = { 'n', 'v' }, desc = 'Copy GitHub link' },
        { '<leader>gY', '<cmd>GitLink!<cr>', mode = { 'n', 'v' }, desc = 'Open GitHub link in browser' },
    },
}
