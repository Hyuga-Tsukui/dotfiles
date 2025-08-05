return {
    'kevinhwang91/nvim-hlslens',
    event = 'VeryLazy',
    -- keys = {
    --     { '*', mode = 'n', desc = 'Search for word under cursor' },
    --     { '#', mode = 'n', desc = 'Replace current word with cursor position' },
    -- },
    config = function()
        local hlslens = require('hlslens')
        hlslens.setup({})

        local kopts = { noremap = true, silent = true }

        vim.keymap.set('n', '*', function()
            local cword = vim.fn.expand('<cword>')
            vim.fn.histadd('search', cword)
            vim.fn.setreg('/', cword)
            vim.opt.hlsearch = true
            hlslens.start()
        end, kopts)

        -- replace the current word with the cursor position
        local function escape_magic(str)
            return vim.fn.escape(str, [[\/.*$^~[]])
        end
        vim.keymap.set('n', '#', function()
            local cword = escape_magic(vim.fn.expand('<cword>'))
            vim.api.nvim_feedkeys(':%s/' .. cword .. '//g', 'n', false)
            -- :%s/word/CURSOR/g
            local ll = vim.api.nvim_replace_termcodes('<Left><Left>', true, true, true)
            vim.api.nvim_feedkeys(ll, 'n', false)
            vim.opt.hlsearch = true
            hlslens.start()
        end, kopts)

        vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
        vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
    end,
}
