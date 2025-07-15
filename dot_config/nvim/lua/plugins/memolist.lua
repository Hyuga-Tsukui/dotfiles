return {
    'glidenote/memolist.vim',
    cmd = {
        'MemoList',
        'MemoNew',
        'MemoGrep',
        'MemoNewWithMeta',
        'MemoNewCopyingMeta',
    },
    config = function()
        vim.g.memolist_path = vim.fn.expand('~/.config/memo/_posts')
    end,
}
