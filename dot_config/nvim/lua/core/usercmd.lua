vim.api.nvim_create_user_command('Task', function()
    local task_file = vim.fn.expand('~/.config/.task.md')
    if vim.fn.filereadable(task_file) == 0 then
        print('Created new task file: ' .. task_file)
    end
    vim.cmd('edit ' .. vim.fn.fnameescape(task_file))
end, { desc = 'Open or create task markdown file' })

vim.api.nvim_create_user_command('TaskToggle', function()
    local line = vim.api.nvim_get_current_line()
    local new_line

    if line:match('%- %[ %]') then
        new_line = line:gsub('%- %[ %]', '- [x]', 1)
    elseif line:match('%- %[x%]') then
        new_line = line:gsub('%- %[x%]', '- [ ]', 1)
    else
        print('No checkbox found in current line')
        return
    end

    vim.api.nvim_set_current_line(new_line)
end, { desc = 'Toggle task checkbox on current line' })

vim.api.nvim_create_user_command('TaskAdd', function(opts)
    local task_file = vim.fn.expand('~/.config/.task.md')
    local line = '- [ ] ' .. opts.args
    local fd = io.open(task_file, 'a')
    if not fd then
        print('Failed to open task file: ' .. task_file)
        return
    end
    fd:write(line .. '\n')
    fd:close()
    print('Added task: ' .. opts.args)
end, {
    nargs = 1,
    desc = 'Append a new task to the markdown task file',
    complete = 'file',
})

-- open task file
vim.keymap.set('n', '<leader>to', ':Task<CR>', { desc = 'Open task file' })

-- toggle
vim.keymap.set('n', '<leader>tx', ':TaskToggle<CR>', { desc = 'Toggle task checkbox' })
