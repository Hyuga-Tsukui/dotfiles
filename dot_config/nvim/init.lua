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
