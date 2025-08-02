return {
    'mluders/comfy-line-numbers.nvim',
    config = function()
        require('comfy-line-numbers').setup({
            hidden_file_types = { 'undotree', 'NvimTree', 'Harpoon' },
            hidden_buffer_types = { 'terminal' },
        })
    end,
}
