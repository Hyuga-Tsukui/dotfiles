return {
    'shellRaining/hlchunk.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        require('hlchunk').setup({
            chunk = {
                enable = true,
                delay = 0,
            },
        })
    end,
}
