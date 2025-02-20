if not vim.g.vscode then
    -- quickfixを開いたときに折り返すようにする
    vim.cmd([[
        autocmd FileType qf setlocal wrap
    ]])
end
