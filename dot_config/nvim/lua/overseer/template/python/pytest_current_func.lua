local ts_utils = require('nvim-treesitter.ts_utils')

local function get_enclosing_function_name()
    local node = ts_utils.get_node_at_cursor()
    local bufnr = vim.api.nvim_get_current_buf()
    local func_name = nil

    while node do
        local type = node:type()
        if type == 'function_definition' or type == 'function_declaration' or type == 'method_definition' then
            for i = 0, node:child_count() - 1 do
                local child = node:child(i)
                local child_type = child:type()
                if child_type == 'identifier' or child_type == 'name' then
                    func_name = vim.treesitter.get_node_text(child, bufnr)
                    if func_name then
                        return func_name
                    end
                end
            end
        end
        node = node:parent()
    end
    return func_name
end

local function get_enclosing_class_name()
    local parser = vim.treesitter.get_parser(0)
    local tree = parser:parse()[1]
    local root = tree:root()
    local cursor_row, cursor_col = unpack(vim.api.nvim_win_get_cursor(0))
    local node = root:descendant_for_range(cursor_row - 1, cursor_col, cursor_row - 1, cursor_col)

    while node do
        if node:type() == 'class_definition' then -- Python用
            for child in node:iter_children() do
                if child:type() == 'identifier' then
                    return vim.treesitter.get_node_text(child, 0)
                end
            end
        end
        node = node:parent()
    end
    return nil
end
return {
    name = 'pytest current function',
    builder = function()
        local file = vim.fn.expand('%')
        local class = get_enclosing_class_name()
        local func = get_enclosing_function_name()
        local target = nil
        if class and func then
            func = class .. '::' .. func
        elseif class then
            target = class
        elseif func then
            target = func
        end
        if not target then
            vim.notify('No function found under cursor', vim.log.levels.ERROR)
            return { cmd = { 'echo' }, args = { 'No function found' }, name = 'invalid task' }
        end

        return {
            cmd = { 'pytest' },
            args = { '-s', '-n', 0, file .. '::' .. target },
            name = 'pytest ' .. target,
            components = {
                { 'on_output_quickfix', open_on_exit = 'failure' },
                'default',
            },
        }
    end,
    condition = {
        filetype = { 'python' },
    },
}
