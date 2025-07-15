return {
    'akinsho/toggleterm.nvim',
    version = '*',
    event = 'VeryLazy',
    config = function()
        local opts = { noremap = true }
        function _G.set_terminal_keymaps()
            vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
        end

        vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')

        vim.keymap.set('n', '<C-p>', function()
            vim.cmd("exe v:count1 . 'ToggleTerm'")
        end, { silent = true })

        local Terminal = require('toggleterm.terminal').Terminal

        local lazygit = Terminal:new({
            cmd = 'lazygit',
            direction = 'float',
            hidden = true,
        })

        function _G.lazygit_toggle()
            lazygit:toggle()
        end

        local oxker = Terminal:new({
            cmd = 'oxker --host ~/.colima/default/docker.sock',
            direction = 'float',
            hidden = true,
        })

        function _G.oxker_toggle()
            oxker:toggle()
        end

        vim.keymap.set('n', '<leader>gg', '<cmd>lua lazygit_toggle()<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>ox', '<cmd>lua oxker_toggle()<CR>', { noremap = true, silent = true })

        require('toggleterm').setup({
            size = function(term)
                return term.direction == 'horizontal' and 15 or vim.o.columns * 0.4
            end,
            direction = 'horizontal',
            close_on_exit = true,
            hide_numbers = true,
            shade_filetypes = {},
            shade_terminals = true,
            shading_factor = 1,
            start_in_insert = true,
            insert_mappings = true,
            persist_size = true,

            highlights = {
                Normal = {
                    link = 'Normal',
                },
            },
        })
    end,
}
