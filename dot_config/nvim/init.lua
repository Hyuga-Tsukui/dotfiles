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
require('core.autocmd')

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_rplugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_tarPlugin = 1

vim.diagnostic.config({
    virtual_text = {
        format = function(diagnostic)
            return string.format('%s (%s: %s)', diagnostic.message, diagnostic.source, diagnostic.code)
        end,
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
        },
    },
    severity_sort = true,
})
