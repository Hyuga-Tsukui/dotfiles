return {
    'https://github.com/lambdalisue/vim-gin',
    dependencies = {
        'https://github.com/vim-denops/denops.vim',
    },
    cmd = { 'GinStatus', 'GinDiff', 'GinLog' },
    -- REF: https://github.com/atusy/dotfiles/blob/ac73621b4839d68ea9983d3a6aaf401405e61179/dot_config/nvim/lua/plugins/git/init.lua#L80C2-L86C5
    config = function()
        local has_delta = vim.fn.executable('delta') == 1
        -- disable delta as <CR> won't work
        local processor = nil
        if has_delta then
            processor = 'delta --no-gitconfig --color-only' -- also requires tsnode-marker to reproduce highlights
            vim.g.gin_diff_persistent_args = { '++processor=' .. processor }
        end
    end,
}
