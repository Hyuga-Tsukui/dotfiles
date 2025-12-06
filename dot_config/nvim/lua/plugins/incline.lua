local function get_relative_path(buf)
    local full_path = vim.api.nvim_buf_get_name(buf)
    local cwd = vim.fn.getcwd()
    -- リポジトリルートを取得（gitリポジトリの場合）
    local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
    if vim.v.shell_error == 0 and git_root then
        return vim.fn.fnamemodify(full_path, ':~:.' .. git_root)
    else
        -- gitリポジトリでない場合はカレントディレクトリからの相対パス
        return vim.fn.fnamemodify(full_path, ':~:.' .. cwd)
    end
end
return {
    'b0o/incline.nvim',
    config = function()
        require('incline').setup({
            window = {
                padding = 0,
                margin = { horizontal = 0 },
            },
            debounce_threshold = {
                rising = 50, -- デフォルト: 10、より高い値に設定
                falling = 100, -- デフォルト: 50
            },
            render = function(props)
                -- local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
                local filename = get_relative_path(props.buf)
                local modified = vim.bo[props.buf].modified
                return {
                    ' ',
                    filename,
                    modified and { ' *', guifg = '#888888', gui = 'bold' } or '',
                    ' ',
                    guibg = '#111111',
                    guifg = '#eeeeee',
                }
            end,
        })
    end,
    -- Optional: Lazy load Incline
    event = 'VeryLazy',
}
