local function get_node_cursor_at(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    local ok, parser = pcall(vim.treesitter.get_parser, bufnr, 'python', {})
    if not ok or not parser then
        return nil
    end
    local pos = vim.api.nvim_win_get_cursor(0)
    -- nvim pos is 1-indexed, treesitter is 0-indexed
    local row, col = pos[1] - 1, pos[2]
    local tree = parser:parse()[1]
    if not tree then
        return nil
    end
    local root = tree:root()
    return root:descendant_for_range(row, col + 1, row, col + 1)
end

local function get_test_function_name_at_cursor(bufnr)
    local curosr_at_node = get_node_cursor_at(bufnr)
    while curosr_at_node do
        if curosr_at_node:type() == 'function_definition' then
            for i = 0, curosr_at_node:child_count() - 1 do
                local child = curosr_at_node:child(i)
                if child ~= nil and child:type() == 'identifier' then
                    local func_name = vim.treesitter.get_node_text(child, 0)
                    if func_name:match('^test_') then
                        return func_name
                    end
                end
            end
        end
        curosr_at_node = curosr_at_node:parent()
    end
    return nil
end

local function get_test_class_name_at_cursor(bufnr)
    local curosr_at_node = get_node_cursor_at(bufnr)
    while curosr_at_node do
        if curosr_at_node:type() == 'class_definition' then
            for i = 0, curosr_at_node:child_count() - 1 do
                local child = curosr_at_node:child(i)
                if child ~= nil and child:type() == 'identifier' then
                    local class_name = vim.treesitter.get_node_text(child, 0)
                    if class_name:match('.*TestCase$') then
                        return class_name
                    end
                end
            end
        end
        curosr_at_node = curosr_at_node:parent()
    end
    return nil
end

---@type overseer.TemplateDefinition
return {
    name = 'pytest curosr at function',
    builder = function()
        local file = vim.fn.expand('%')
        local func_name = get_test_function_name_at_cursor()
        local class_name = get_test_class_name_at_cursor()

        local exec_target = class_name
        if func_name then
            exec_target = exec_target .. '::' .. func_name
        end

        if not exec_target then
            vim.notify('テストが見つかりませんでした', vim.log.levels.ERROR)
            return {
                cmd = { 'echo' },
                args = { 'テストが見つかりませんでした' },
                name = '無効なタスク',
            }
        end

        ---@type overseer.TaskDefinition
        return {
            cmd = { 'pytest' },
            args = { '-s', '-n', '0', file .. '::' .. exec_target },
            name = 'pytest ' .. exec_target,
            components = {
                { 'open_output', focus = false, direction = 'vertical' },
                -- { 'on_complete_dispose', require_view = { 'FAILURE' } },
                -- {
                --     'on_output_notify',
                --     delay_ms = 2000, -- 2秒後に通知開始
                --     max_lines = 1, -- 表示する行数
                --     output_on_complete = true, -- 完了時も出力を表示
                -- },
                'default',
            },
        }
    end,
    condition = {
        filetype = { 'python' },
    },
}
