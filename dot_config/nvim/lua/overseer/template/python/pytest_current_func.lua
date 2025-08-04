local function get_current_function()
    local ts_utils = require('nvim-treesitter.ts_utils')
    local node = ts_utils.get_node_at_cursor()
    while node do
        if node:type() == 'function_definition' then
            local name = node:child(1) -- 'name' ノード
            return vim.treesitter.query.get_node_text(name, 0)
        end
        node = node:parent()
    end

    -- fallback: Python function name を regex で取得
    local line = vim.api.nvim_get_current_line()
    local name = string.match(line, '^def%s+([%w_]+)')
    return name
end

return {
    name = 'pytest current function',
    builder = function(_)
        local file = vim.fn.expand('%')
        local func = get_current_function()
        if not func then
            vim.notify('No function found under cursor', vim.log.levels.ERROR)
            return
        end
        return {
            cmd = { 'pytest' },
            args = { file .. '::' .. func },
            name = 'pytest ' .. func,
            components = {
                { 'on_output_quickfix', open = true },
                'default',
            },
        }
    end,
    condition = {
        filetype = { 'python' },
    },
}
