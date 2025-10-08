return {
    'RRethy/nvim-treesitter-textsubjects',
    config = function()
        require('nvim-treesitter-textsubjects').configure({
            prev_selection = ',', -- (Optional) keymap to select the previous selection
            keymaps = {
                ['.'] = 'textsubjects-smart', -- (Optional) keymap to smartly select the target
                [';'] = 'textsubjects-container-outer', -- (Optional) keymap to select the outer container
                ['i;'] = 'textsubjects-container-inner', -- (Optional) keymap to select the inner container
            },
        })
    end,
}
