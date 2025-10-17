if not vim.g.vscode then
    -- quickfixを開いたときに折り返すようにする
    vim.cmd([[
        autocmd FileType qf setlocal wrap
    ]])
end

vim.api.nvim_create_autocmd('BufReadPost', {
    pattern = '*',
    callback = function()
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        for _, line in ipairs(lines) do
            if line:match('^<<<<<<<') then
                vim.diagnostic.enable(false)
                vim.notify('Diagnostics disabled due to git conflict', vim.log.levels.INFO)
                return
            end
        end
    end,
})
