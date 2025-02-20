if not vim.g.vscode then
    require("core.autocmd")
    require("core.options")
    require("core.keymaps")
    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.opt.laststatus = 0 -- status-line系のpluginへの切り替え時のちらつきを防ぐためにデフォルトは表示しないようにする.

    require("config.lazy")

    vim.diagnostic.config({
        virtual_text = {
            format = function(diagnostic)
                return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
            end,
        },
    })
end
