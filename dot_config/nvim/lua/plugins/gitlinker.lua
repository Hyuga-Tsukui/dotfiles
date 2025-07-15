-- GitLinkコマンドで、Vモードで選択した行のGitHubリンクをクリップボードにコピーする
-- GitLink!とすることで、ブラウザで開くことも可能
-- REF: https://github.com/linrongbin16/gitlinker.nvim
return {
    'linrongbin16/gitlinker.nvim',
    cmd = 'GitLink',
    config = function()
        require('gitlinker').setup()
    end,
}
