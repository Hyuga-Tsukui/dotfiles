return {
    'romgrk/barbar.nvim',
    dependencies = {
        'lewis6991/gitsigns.nvim',
        'nvim-tree/nvim-web-devicons',
    },
    -- event = { 'BufRead', 'BufNewFile' },
    event = 'VeryLazy',
    cond = function()
        local exclude_filetypes = { 'NvimTree' }
        return not vim.tbl_contains(exclude_filetypes, vim.bo.filetype)
    end,
    config = function()
        require('barbar').setup({
            sidebar_filetypes = {
                -- Use the default values: {event = 'BufWinLeave', text = '', align = 'left'}
                NvimTree = true,
                -- Or, specify the text used for the offset:
                undotree = {
                    text = 'undotree',
                    align = 'center', -- *optionally* specify an alignment (either 'left', 'center', or 'right')
                },
                -- Or, specify the event which the sidebar executes when leaving:
                ['neo-tree'] = { event = 'BufWipeout' },
                -- Or, specify all three
                Outline = { event = 'BufWinLeave', text = 'symbols-outline', align = 'right' },
            },
            animation = false,
            icons = {
                filetype = {
                    custom_colors = false,
                    enabled = true,
                },
                separator_at_end = false,

                separator = { left = '▕', right = '▕' },
                inactive = {
                    separator = {
                        left = '', -- ← this is the fix
                    },
                },
            },
        })
        vim.keymap.set('n', '<TAB>', '<Cmd>BufferPrevious<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<S-TAB>', '<Cmd>BufferNext<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>p', '<Cmd>BufferPick<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>w', '<Cmd>BufferClose<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>ac', '<Cmd>BufferCloseAllButCurrent<CR>', { noremap = true, silent = true })

        vim.api.nvim_set_hl(0, 'BufferCurrent', { bg = 'NONE', fg = '#FFD700', bold = true }) -- 明るい色+太字
        vim.api.nvim_set_hl(0, 'BufferCurrentIndex', { bg = 'NONE', fg = '#FFD700', bold = true })
        vim.api.nvim_set_hl(0, 'BufferCurrentMod', { bg = 'NONE', fg = '#FF4500', italic = true }) -- 修正マークを目立たせる
        vim.api.nvim_set_hl(0, 'BufferCurrentTarget', { bg = 'NONE', fg = '#FF6347', underline = true }) -- ターゲットを下線で強調
        vim.api.nvim_set_hl(0, 'BufferCurrentIcon', { bg = 'NONE' }) -- アイコン背景透過+明るい緑色
        vim.api.nvim_set_hl(0, 'BufferInactiveSign', { bg = 'NONE', fg = '#7c7c7c' }) -- 非アクティブタブのアイコンも透過
        vim.api.nvim_set_hl(0, 'BufferCurrentSign', { bg = 'NONE', fg = '#7c7c7c' }) -- 非アクティブタブのアイコンも透過
    end,
}
