return {
    'numToStr/Comment.nvim',
    keys = { 'gcc', 'gbc', 'gc', 'gb' },
    ft = { 'terraform' }, -- Terraformファイルを明示,Tfファイルの際だけ、なぜかVモードでの遅延ロードが失敗する
    opts = {},
}
