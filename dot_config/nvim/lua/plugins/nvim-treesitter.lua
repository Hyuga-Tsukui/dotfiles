return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    exclude = { 'NvimTree' },
    dependencies = {
        -- 'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/nvim-treesitter-context',
    },
    config = function()
        local configs = require('nvim-treesitter.configs')
        require('treesitter-context').setup({
            enable = true,
            multiwindow = false,
            max_lines = 0,
            min_window_height = 0,
            line_numbers = true,
            multiline_threshold = 20,
            trim_scope = 'outer',
            mode = 'cursor',
            separator = '-',
            zindex = 20,
            on_attach = nil,
        })

        configs.setup({
            ensure_installed = {
                'vimdoc',
                'javascript',
                'typescript',
                'lua',
                'go',
                'python',
            },
            sync_install = false,
            ignore_install = {
                'markdown',
            },
            auto_install = true,
            indent = { enable = true },

            modules = {},
            highlight = {
                enable = true,
                disable = { 'markdown' }, -- disable markdown highlighting
                additional_vim_regex_highlighting = { 'python' },
            },
            -- textobjects = {
            --     select = {
            --         enable = true,
            --         lookahead = true,
            --         keymaps = {
            --             ['af'] = '@function.outer', -- Select around function
            --             ['if'] = '@function.inner', -- Select inside function
            --             ['ac'] = '@class.outer', -- Select around class
            --             ['ic'] = '@class.inner', -- Select inside class
            --             ['ap'] = '@parameter.outer', -- Select around parameter
            --             ['ip'] = '@parameter.inner', -- Select inside parameter"
            --             ['as'] = '@local.scope', -- Select around scope
            --             ['is'] = '@local.scope', -- Select inside scope
            --             ['ai'] = '@conditional.outer', -- Select around conditional
            --             ['ii'] = '@conditional.inner', -- Select inside conditional
            --             ['al'] = '@loop.outer', -- Select around loop
            --             ['il'] = '@loop.inner', -- Select inside loop
            --         },
            --     },
            --     move = {
            --         enable = true,
            --         set_jumps = true,
            --         goto_next_start = {
            --             [']m'] = '@function.outer',
            --             [']]'] = '@class.outer',
            --         },
            --         goto_previous_start = {
            --             ['[m'] = '@function.outer',
            --             ['[['] = '@class.outer',
            --         },
            --         swap = {
            --             enable = true,
            --             swap_next = {
            --                 ['<leader>a'] = '@parameter.inner',
            --             },
            --             swap_previous = {
            --                 ['<leader>A'] = '@parameter.inner',
            --             },
            --         },
            --     },
            -- },
        })
        -- REF: https://github.com/nvim-treesitter/nvim-treesitter/issues/2825#issuecomment-1547409415
        vim.api.nvim_create_autocmd({
            'BufEnter',
            'BufWinEnter',
        }, {
            pattern = { '*.json' },
            callback = function()
                vim.cmd('set conceallevel=0')
            end,
        })
    end,
}
