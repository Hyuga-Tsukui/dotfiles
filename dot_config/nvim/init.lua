vim.loader.enable()
-- TODO refactor file type detection
-- neovim not resolving filetype for terraform files
vim.filetype.add({
    extension = {
        tf = 'terraform',
        tfvars = 'terraform',
    },
})

require('core.options')
require('core.keymaps')
require('config.lazy')

if not vim.g.vscode then
    require('core.autocmd')

    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    vim.diagnostic.config({
        virtual_text = {
            format = function(diagnostic)
                return string.format('%s (%s: %s)', diagnostic.message, diagnostic.source, diagnostic.code)
            end,
        },
    })
end

local ts_utils = require('nvim-treesitter.ts_utils')

local function get_enclosing_function_name()
    local node = ts_utils.get_node_at_cursor()
    local bufnr = vim.api.nvim_get_current_buf()

    while node do
        local type = node:type()
        if type == 'function_definition' or type == 'function_declaration' or type == 'method_definition' then
            for i = 0, node:child_count() - 1 do
                local child = node:child(i)
                local child_type = child:type()
                if child_type == 'identifier' or child_type == 'name' then
                    local text = vim.treesitter.get_node_text(child, bufnr)
                    print('Function name: ' .. text)
                    return
                end
            end
        end
        node = node:parent()
    end

    print('No enclosing function found.')
end

vim.api.nvim_create_user_command('GetFunctionName', get_enclosing_function_name, {})

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

-- Neovim コマンド登録
vim.api.nvim_create_user_command('EnclosingClassName', function()
    local name = get_enclosing_class_name()
    if name then
        print('Enclosing class: ' .. name)
    else
        print('No enclosing class found')
    end
end, {})
